class DeviceDetector
  class ModelExtractor < MetadataExtractor

    private

    def metadata_string
      String(regex_meta['model'])
    end

  end
end
