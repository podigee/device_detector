class DeviceDetector
  class ModelExtractor < VersionExtractor

    private

    def metadata_string
      regex_meta['model']
    end

  end
end
