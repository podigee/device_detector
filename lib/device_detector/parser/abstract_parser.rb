# frozen_string_literal: true

class DeviceDetector
  module Parser
    class AbstractParser
      # overriden
      def self.client_hint_mapping
        {}
      end

      REGEX_CACHE = ::DeviceDetector::MemoryCache.new({})
      private_constant :REGEX_CACHE

      USER_AGENT_CLIENT_HINTS_FRAGMENT_REGEX = %r{Android (?:10[.\d]*; K(?: Build/|[;)])|1[1-5]\)) AppleWebKit}i

      DESKTOP_FRAGMENT_REGEX = /(?:Windows (?:NT|IoT)|X11; Linux x86_64)/i
      DESKTOP_FRAGMENT_NON_DESKTOP_REGEX = %r{CE-HTML| Mozilla/|Andr[o0]id|Tablet|Mobile|iPhone|Windows Phone|ricoh|OculusBrowser|PicoBrowser|Lenovo|compatible; MSIE|Trident/|Tesla/|XBOX|FBMD/|ARM; ?([^)]+)}i

      def use(uas, hints)
        @user_agent = uas
        @client_hints = hints
      end

      attr_writer :user_agent, :client_hints

      protected

      def empty?(var)
        return true if var.nil?
        return true if var.empty?

        false
      end

      def fuzzy_compare(val1, val2)
        val1.to_s.downcase.gsub(' ', '') == val2.to_s.downcase.gsub(' ', '')
      end

      def build_version(version_string, matches)
        return unless version_string

        version_string = build_by_match(version_string, matches)
        version_string = version_string.gsub('_', '.')

        version_string.strip.sub(/^(\.+)/, '').sub(/(\.+)$/, '')
      end

      def build_by_match(item, matches)
        result = item
        matches.each.with_index do |match, index|
          result = result.gsub("$#{index + 1}", match.to_s)
        end
        result.strip
      end

      def restore_user_agent_from_client_hints
        return if @client_hints.nil?

        device_model = @client_hints.model

        return if device_model == ''

        # Restore Android User Agent
        # https://github.com/matomo-org/device-detector/blob/6.4.5/Parser/AbstractParser.php#L144
        if user_agent_client_hints_fragment?
          os_version = @client_hints.operating_system_version || ''
          self.user_agent = @user_agent.sub(
            /(Android (?:10[.\d]*; K|1[1-5]))/,
            "Android #{os_version == '' ? 10 : os_version}; #{device_model}"
          )
        end

        return unless desktop_fragment?

        self.user_agent = @user_agent.sub(
          /(X11; Linux x86_64)/,
          "'X11; Linux x86_64; #{device_model}"
        )
      end

      def apply_client_hint_mapping(name)
        downcased_name = name.downcase
        mapped_result = nil

        self.class.client_hint_mapping.detect do |mapped_name, client_hints|
          client_hints.detect do |client_hint|
            if downcased_name == client_hint.downcase
              mapped_result = mapped_name
              break mapped_name
            end
          end
        end

        mapped_result || name
      end

      def user_agent_client_hints_fragment?
        @user_agent.match?(USER_AGENT_CLIENT_HINTS_FRAGMENT_REGEX)
      end

      def desktop_fragment?
        match_user_agent_r(DESKTOP_FRAGMENT_REGEX) &&
          !match_user_agent_r(DESKTOP_FRAGMENT_NON_DESKTOP_REGEX)
      end

      def fixture_file
        ''
      end

      def parser_name
        ''
      end

      def regexes
        REGEX_CACHE.get_or_set("regexes-#{fixture_file}") do
          object = load_regexes

          if object.is_a?(Array)
            object.map { |e| prepare_definition_for_cache(e) }
          elsif object.is_a?(Hash)
            object.transform_values { |v| prepare_definition_for_cache(v) }
          else
            raise "Invalid fixture loaded from #{fixture_file}: #{object.class}"
          end
        end
      end

      def load_regexes
        REGEX_CACHE.get_or_set(fixture_file) do
          YAML.safe_load_file(fixture_file,
                              permitted_classes: [String, Integer, NilClass, Array, Hash])
        end
      end

      def pre_match_overall?
        regex_from_user_agent_cache('overall') do
          overall_regex = REGEX_CACHE.get_or_set("overall-#{fixture_file}") do
            regex_list = load_regexes
            regex_list = regex_list.values if regex_list.is_a?(Hash)

            full_regex = regex_list.reduce('') do |res, regex|
              if regex
                "#{res}|#{regex['regex']}"
              else
                res
              end
            end.delete_prefix('|')

            build_regex_for_ua(full_regex)
          end

          match_user_agent_r(overall_regex)
        end
      end

      def match_user_agent(regex)
        regex = build_regex_for_ua(regex) if regex.is_a?(String)

        match_user_agent_r(regex)
      end

      def match_user_agent_r(regex)
        match = begin
          @user_agent.match(regex)
        rescue RegexpError
          ua = @user_agent.encode(
            ::Encoding::ASCII, invalid: :replace, undef: :replace, replace: ''
          )
          ua.match(regex)
        end

        return unless match

        match.captures || []
      end

      def build_regex_for_ua(str)
        str = str.gsub('/', '\/')
        Regexp.new("(?:^|[^A-Z0-9_-]|[^A-Z0-9-]_|sprd-|MZ-)(?:#{str})", Regexp::IGNORECASE)
      end

      def prepare_definition_for_cache(definition)
        definition = deep_symbolize_keys(definition)

        return definition if parser_name == 'AppHints' # just a hash look up table
        return definition if parser_name == 'BrowserHints' # just a hash look up table

        # pre-parse Regex if needed
        if definition.key?(:regex)
          regex = definition[:regex]
          definition[:regex] = build_regex_for_ua(regex)
        end

        if definition.key?(:models)
          models = definition[:models]
          definition[:models] = models.map do |r|
            r[:regex] = build_regex_for_ua(r[:regex])
            r
          end
        end

        definition
      end

      def regex_from_user_agent_cache(key = nil, &)
        key = "#{parser_name}_#{@user_agent}#{key}"
        DeviceDetector.cache.get_or_set(key, &)
      end

      def deep_symbolize_keys(obj)
        case obj
        when Hash
          obj.each_with_object({}) do |(key, value), result|
            new_key = key.respond_to?(:to_sym) ? key.to_sym : key
            result[new_key] = deep_symbolize_keys(value)
          end
        when Array
          obj.map { |item| deep_symbolize_keys(item) }
        else
          obj
        end
      end

      def satisfied_by_version(requirement_string, version)
        requirement = Gem::Requirement.new(requirement_string)
        requirement.satisfied_by?(Gem::Version.new(version))
      end
    end
  end
end
