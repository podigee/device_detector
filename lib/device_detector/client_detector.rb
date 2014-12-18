class DeviceDetector
  class ClientDetector

    attr_reader :user_agent

    def initialize(user_agent)
      @user_agent = user_agent
    end

    def call
      DeviceDetector::Client.new(user_agent, matching_regex)
    end

    private

    def matching_regex
      regexes.find { |r| user_agent =~ Regexp.new(r['regex']) }
    end

    def regexes
      YAML.load(filepaths.map { |filepath| File.read(filepath) }.join)
    end

    def filepaths
      filenames.map do |filename|
        File.join(DeviceDetector::ROOT, 'regexes', filename)
      end
    end

    def filenames
      [
        'browsers.yml',
        'feed_readers.yml',
        'libraries.yml',
        'mediaplayers.yml',
        'mobile_apps.yml',
        'pim.yml'
      ]
    end
  end
end
