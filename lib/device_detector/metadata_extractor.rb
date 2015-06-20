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
        metadata_string.gsub(/\$(\d)/) {
          match_data[$1.to_i].to_s
        }.strip
      end
    end

    def regex
      @regex ||= regex_meta[:regex]
    end

  end
end

