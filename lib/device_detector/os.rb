class DeviceDetector
  class OS < Parser

    def full_version
      raw_version = super

      # This solution won't scale, but for now it will do
      if raw_version && name == 'Mac'
        raw_version.split('_').join('.')
      end
    end

    private

    def filenames
      ['oss.yml']
    end

  end

end
