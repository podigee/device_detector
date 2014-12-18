class DeviceDetector
  class VersionExtractor < Struct.new(:user_agent, :regex_meta)

    def call
      regex_meta.any? ? extract_version : nil
    end

    private

    def version_string
      regex_meta['version']
    end

    def extract_version
      user_agent.match(regex) do |match_data|
        replace_version_string_with(match_data)
      end
    end

    def replace_version_string_with(match_data)
      string = version_string

      1.upto(9) do |index|
        string = string.gsub(/\$#{index}/, match_data[index]) if match_data[index]
      end

      string
    end

    def regex
      Regexp.new(regex_meta['regex'])
    end

  end
end

