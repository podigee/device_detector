class DeviceDetector
  class ModelExtractor < VersionExtractor

    private

    def version_string
      regex_meta['model']
    end

  end
end
