class DeviceDetector
  class OS

    def initialize(user_agent, regex_meta)
      @user_agent = user_agent
      @regex_meta = regex_meta
    end

    def name
      @regex_meta['name']
    end

    def full_version
      VersionExtractor.new(@user_agent, @regex_meta).call
    end

  end

end
