class DeviceDetector
  class Client < Parser

    def known?
      regex_meta.any?
    end

    def library?
      regex_meta[:path] == :'client/libraries.yml'
    end

    private

    def filenames
      [
        'client/feed_readers.yml',
        'client/mobile_apps.yml',
        'client/mediaplayers.yml',
        'client/pim.yml',
        'client/browsers.yml',
        'client/libraries.yml',
      ]
    end
  end
end
