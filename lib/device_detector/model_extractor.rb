class DeviceDetector
  class ModelExtractor < MetadataExtractor

    private

    def metadata_string
      regex_meta['model']
    end

  end
end
