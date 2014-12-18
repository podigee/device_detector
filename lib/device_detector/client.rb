class DeviceDetector
  class Client < Parser

    def known?
      regex_meta.any?
    end

    private

    def filenames
      [
        'browsers.yml',
        'feed_readers.yml',
        'libraries.yml',
        'mediaplayers.yml',
        'mobile_apps.yml',
        'pim.yml'
      ]
    end
  end
end
