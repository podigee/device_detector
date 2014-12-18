class DeviceDetector
  class Client

    def initialize(user_agent, regex_meta)
      @user_agent = user_agent
      @regex_meta = regex_meta
    end

    def name
      @regex_meta['name']
    end

    def full_version
      extract_version
    end

    private

    def version_string
      @regex_meta['version']
    end

    def extract_version
      @user_agent.match(regex) do |match_data|
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
      Regexp.new(@regex_meta['regex'])
    end

  end
end
