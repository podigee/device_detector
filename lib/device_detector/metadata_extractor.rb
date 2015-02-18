class DeviceDetector
  class MetadataExtractor < Struct.new(:user_agent, :regex_meta)

    def call
      regex_meta.any? ? extract_metadata : nil
    end

    private

    def metadata_string
      message = "#{self.name} (a child of MetadataExtractor) must implement the '#{__method__}' method."
      fail NotImplementedError, message
    end

    def extract_metadata
      user_agent.match(regex) do |match_data|
        replace_metadata_string_with(match_data)
      end
    end

    def replace_metadata_string_with(match_data)
      string = metadata_string

      1.upto(9) do |index|
        matched_data = String(match_data[index])
        string = string.gsub(/\$#{index}/, matched_data)
      end

      string.strip
    end

    def regex
      Regexp.new(regex_meta['regex'])
    end

  end
end

