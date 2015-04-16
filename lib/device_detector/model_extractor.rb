class DeviceDetector
  class ModelExtractor < MetadataExtractor

    def call
      s = super.to_s.gsub('_',' ').strip
      s.empty? ? nil : s
    end

    private

    def metadata_string
      String(regex_meta[:model])
    end

    def regex
      @regex ||= regex_meta[:regex_model] || regex_meta[:regex]
    end

  end
end
