class DeviceDetector
  class NameExtractor < MetadataExtractor

    def call
      if regex_meta['name']
        extract_metadata
      else
        nil
      end
    end

    private

    def metadata_string
      regex_meta['name']
    end

  end
end
