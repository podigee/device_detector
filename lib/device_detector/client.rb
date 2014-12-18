class DeviceDetector
  class Client

    def initialize(regex_meta)
      @regex_meta = regex_meta
    end

    def name
      @regex_meta['name']
    end

  end
end
