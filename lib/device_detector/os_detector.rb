class DeviceDetector
  class OSDetector

    attr_reader :user_agent

    def initialize(user_agent)
      @user_agent = user_agent
    end

    def call
      DeviceDetector::OS.new(matching_regex)
    end

    private

    def matching_regex
      regexes.find { |r| user_agent =~ Regexp.new(r['regex']) }
    end

    def regexes
      @regexes ||= YAML.load(File.read(filepath))
    end

    def filepath
      File.join(DeviceDetector::ROOT, 'regexes', 'oss.yml')
    end

  end
end
