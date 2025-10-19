# frozen_string_literal: true

require 'yaml'

require 'device_detector/version'
require 'device_detector/memory_cache'
require 'device_detector/client_hint'

require 'device_detector/parser/abstract_parser'
require 'device_detector/parser/bot'
require 'device_detector/parser/operating_system'
require 'device_detector/parser/vendor_fragment'
require 'device_detector/parser/client/abstract_client_parser'
require 'device_detector/parser/client/feed_reader'
require 'device_detector/parser/client/mobile_app'
require 'device_detector/parser/client/media_player'
require 'device_detector/parser/client/pim'
require 'device_detector/parser/client/browser'
require 'device_detector/parser/client/browser_module/engine'
require 'device_detector/parser/client/browser_module/engine/version'
require 'device_detector/parser/client/library'
require 'device_detector/parser/device/abstract_device_parser'
require 'device_detector/parser/device/hbb_tv'
require 'device_detector/parser/device/shell_tv'
require 'device_detector/parser/device/notebook'
require 'device_detector/parser/device/console'
require 'device_detector/parser/device/car_browser'
require 'device_detector/parser/device/camera'
require 'device_detector/parser/device/portable_media_player'
require 'device_detector/parser/device/mobile'

class DeviceDetector
  MAJOR_VERSION_2 = Gem::Version.new('2.0')
  MAJOR_VERSION_3 = Gem::Version.new('3.0')
  MAJOR_VERSION_4 = Gem::Version.new('4.0')
  MAJOR_VERSION_8 = Gem::Version.new('8.0')

  REGEX_CACHE = ::DeviceDetector::MemoryCache.new({})
  private_constant :REGEX_CACHE

  class << self
    @@parser_classes = [
      Parser::Client::FeedReader,
      Parser::Client::MobileApp,
      Parser::Client::MediaPlayer,
      Parser::Client::Pim,
      Parser::Client::Browser,
      Parser::Client::Library,
      Parser::Device::HbbTv,
      Parser::Device::ShellTv,
      Parser::Device::Notebook,
      Parser::Device::Console,
      Parser::Device::CarBrowser,
      Parser::Device::Camera,
      Parser::Device::PortableMediaPlayer,
      Parser::Device::Mobile,
      Parser::Bot
    ]

    def root
      @root ||= File.expand_path('..', __dir__)
    end

    def regexes_dir
      @regexes_dir ||= File.join(root, 'regexes')
    end

    def parser_classes
      @@parser_classes
    end
  end

  attr_reader :client_hint, :user_agent

  def initialize(user_agent = nil, headers = nil)
    @parsers = {}

    @vendor_fragment_parser = DeviceDetector::Parser::VendorFragment.new
    @operating_system_parser = DeviceDetector::Parser::OperatingSystem.new

    self.class.parser_classes.each do |klass|
      add_parser(klass.new)
    end

    use(user_agent, headers) if user_agent || headers
  end

  def name
    return unless client_result

    client_result[:name]
  end

  def full_version
    return unless client_result

    client_result[:version]
  end

  def os_family
    presence(os_result[:family])
  end

  def os_name
    presence(os_result[:name])
  end

  def os_full_version
    presence(os_result[:version])
  end

  def device_name
    presence(device_result[:model])
  end

  def device_brand
    presence(device_result[:brand])
  end

  def device_type
    presence(device_result[:device])
  end

  def known?
    !client_result.nil?
  end

  def bot?
    bot_result ? true : false
  end

  def bot_name
    bot_result&.fetch(:name, nil)
  end

  def use(user_agent, headers = nil)
    reset
    self.user_agent = user_agent
    self.headers = headers
    self
  end

  class << self
    class Configuration
      attr_accessor :max_cache_keys

      def to_hash
        { max_cache_keys: max_cache_keys }
      end
    end

    def config
      @config ||= Configuration.new
    end

    def cache
      @cache ||= MemoryCache.new(config.to_hash)
    end

    def configure
      @config = Configuration.new
      yield(config)
    end
  end

  private

  def bot_result
    return @bot_result if @bot_parsed

    @bot_parsed = true
    @bot_result = parse_bot if should_parse?
  end

  def client_result
    return @client_result if @client_parsed

    @client_parsed = true

    @client_result = if bot? || !should_parse?
                       nil
                     else
                       parse_client
                     end
  end

  def os_result
    return @os_result if @os_parsed

    @os_parsed = true
    @os_result = if bot? || !should_parse?
                   {}
                 else
                   parse_os
                 end
  end

  def device_result
    return @device_result if @device_parsed

    @device_parsed = true
    @device_result = if bot? || !should_parse?
                       {}
                     else
                       parse_device

                       {
                         model: @model,
                         brand: @brand,
                         device: @device
                       }
                     end
  end

  def parse_bot
    @parsers.fetch(:bot, []).each do |parser|
      parser.use(@user_agent, @client_hints)

      bot = parser.parse

      return bot if bot
    end
    nil
  end

  def parse_os
    parser = @operating_system_parser
    parser.use(@user_agent, @client_hints)

    parser.parse || {}
  end

  def parse_client
    @parsers.fetch(:client, []).each do |parser|
      parser.use(@user_agent, @client_hints)

      client = parser.parse

      return client if client
    end
    nil
  end

  def parse_device
    @parsers.fetch(:device, []).each do |parser|
      parser.use(@user_agent, @client_hints)

      device = parser.parse

      next unless device

      @device = device[:device_type]
      @model = presence(device[:model])
      @brand = presence(device[:brand])
      break
    end

    @model = @client_hints.model if !@model && @client_hints

    unless @brand
      @vendor_fragment_parser.use(@user_agent)
      @brand = presence(@vendor_fragment_parser.parse || nil)
    end

    if @brand == 'Apple' && !DeviceDetector::Parser::OperatingSystem::APPLE_OS_NAMES.include?(os_name)
      @device = nil
      @brand = nil
      @model = nil
    end

    if !@brand && DeviceDetector::Parser::OperatingSystem::APPLE_OS_NAMES.include?(os_name)
      @brand = 'Apple'
    end

    @device = 'wearable' if @device.nil? && android_vr_fragment?

    if @device.nil? && os_family == 'Android' \
      && match_user_agent('Chrome/[.0-9]*')

      @device = if match_user_agent('(?:Mobile|eliboM)')
                  'smartphone'
                else
                  'tablet'
                end
    end

    @device = 'tablet' if @device == 'smartphone' && match_user_agent('Pad/APad')

    if @device.nil? && (android_tablet_fragment? \
      || match_user_agent('Opera Tablet'))
      @device = 'tablet'
    end

    @device = 'smartphone' if @device.nil? && android_mobile_fragment?

    if @device.nil? && os_name == 'Android' && presence(os_full_version)
      full_version = Gem::Version.new(os_full_version)
      if full_version < MAJOR_VERSION_2
        @device = 'smartphone'
      elsif full_version >= MAJOR_VERSION_3 &&
            full_version < MAJOR_VERSION_4
        @device = 'tablet'
      end
    end

    @device = 'smartphone' if @device == 'feature phone' && os_family == 'Android'

    @device = 'feature phone' if @device.nil? && os_name == 'Java ME'

    @device = 'feature phone' if os_name == 'KaiOS'

    if @device.nil? && touch_enabled? &&
       (os_name == 'Windows RT' ||
        (os_name == 'Windows' && os_full_version &&
         Gem::Version.new(os_full_version) >= MAJOR_VERSION_8))
      @device = 'tablet'
    end

    @device = 'desktop' if @device.nil? && match_user_agent('Puffin/(?:\d+[.\d]+)[LMW]D')

    @device = 'smartphone' if @device.nil? && match_user_agent('Puffin/(?:\d+[.\d]+)[AIFLW]P')

    @device = 'tablet' if @device.nil? && match_user_agent('Puffin/(?:\d+[.\d]+)[AILW]T')

    @device = 'tv' if match_user_agent('Opera TV Store| OMI/')

    if os_name == 'Coolita OS'
      @device = 'tv'
      @brand = 'coocaa'
    end

    if !%w[tv peripheral].include?(@device) &&
       match_user_agent('Andr0id|(?:Android(?: UHD)?|Google) TV|\(lite\) TV|BRAVIA|Firebolt| TV$')
      @device = 'tv'
    end

    @device = 'tv' if @device.nil? && match_user_agent('SmartTV|Tizen.+ TV .+$')

    if DeviceDetector::Parser::Client::AbstractClientParser::TV_CLIENT_NAMES.include?(name)
      @device = 'tv'
    end

    @device = 'tv' if @device.nil? && match_user_agent('\(TV;')

    if @device != 'desktop' && @user_agent.to_s.include?('Desktop') && desktop_fragment?
      @device = 'desktop'
    end

    return if !@device.nil? || !desktop?

    @device = 'desktop'
  end

  # Sets the useragent to be parsed
  # https://github.com/matomo-org/device-detector/blob/6.4.5/DeviceDetector.php#L245
  def user_agent=(user_agent)
    @user_agent = user_agent || ''

    return if @user_agent.encoding.name == 'UTF-8'

    @user_agent = @user_agent.encode('utf-8', 'binary', undef: :replace, replace: '')
  end

  def headers=(headers)
    @headers = headers

    @client_hints = nil
    @client_hints = ClientHint.new(@headers) if @headers && !@headers.empty?
  end

  # Resets all detected data
  def reset
    @bot_result    = nil
    @bot_parsed    = nil

    @client_result = nil
    @client_parsed = nil

    @os_result     = nil
    @os_parsed     = nil

    @device_result = nil
    @device_parsed = nil

    @model  = nil
    @brand  = nil
    @device = nil
  end

  def add_parser(parser)
    type = parser.parser_type

    @parsers[type] ||= []
    @parsers[type] << parser
  end

  def match_user_agent(regex)
    regexp = REGEX_CACHE.get_or_set(regex) do
      src = regex.gsub('/', '\/')
      Regexp.new("(?:^|[^A-Z_-])(?:#{src})", Regexp::IGNORECASE)
    end

    match = @user_agent.match(regexp)
    return unless match

    match.captures || []
  end

  def android_vr_fragment?
    match_user_agent('Android( [.0-9]+)?; Mobile VR;| VR ')
  end

  def android_tablet_fragment?
    match_user_agent('Android( [.0-9]+)?; Tablet;|Tablet(?! PC)|.*\-tablet$')
  end

  def android_mobile_fragment?
    match_user_agent('Android( [.0-9]+)?; Mobile;|.*\-mobile$')
  end

  def desktop_fragment?
    match_user_agent('Desktop(?: (x(?:32|64)|WOW64))?;')
  end

  def desktop?
    return false if os_name.nil? || os_name.empty? || os_name == 'UNK'

    return false if uses_mobile_browser?

    DeviceDetector::Parser::OperatingSystem.desktop_os?(os_name)
  end

  def uses_mobile_browser?
    client_result&.fetch(:type) == 'browser' && DeviceDetector::Parser::Client::Browser.mobile_only_browser?(name)
  end

  def touch_enabled?
    match_user_agent('Touch')
  end

  def should_parse?
    if (@user_agent.nil? || @user_agent.empty? || @user_agent !~ /[a-z]/i) && @client_hints.nil?
      return false
    end

    true
  end

  def presence(var)
    return nil if var.to_s.empty?

    var
  end
end
