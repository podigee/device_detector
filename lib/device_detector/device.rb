class DeviceDetector
  class Device < Parser

    # order is relevant for testing with fixtures
    DEVICE_NAMES = [
        'desktop',
        'smartphone',
        'tablet',
        'feature phone',
        'console',
        'tv',
        'car browser',
        'smart display',
        'camera',
        'portable media player',
        'phablet'
    ]

    def known?
      regex_meta.any?
    end

    def name
      ModelExtractor.new(user_agent, regex_meta).call
    end

    def type
      hbbtv? ? 'tv' : regex_meta[:device]
    end

    private

    # The order of files needs to be the same as the order of device
    # parser classes used in the piwik project.
    def filenames
      [
        'device/televisions.yml',
        'device/consoles.yml',
        'device/car_browsers.yml',
        'device/cameras.yml',
        'device/portable_media_player.yml',
        'device/mobiles.yml',
      ]
    end

    def matching_regex
      from_cache([self.class.name, user_agent]) do
        regex_list = hbbtv? ? regexes_for_hbbtv : regexes_other
        regex = regex_list.find { |r| user_agent =~ r[:regex] }
        if regex && regex[:models]
          model_regex = regex[:models].find { |m| user_agent =~ m[:regex]}
          if model_regex
            regex = regex.merge(:regex_model => model_regex[:regex], :model => model_regex[:model])
            regex[:device] = model_regex[:device] if model_regex.key?(:device)
            regex.delete(:models)
          end
        end
        regex
      end
    end

    def hbbtv?
      @regex_hbbtv ||= build_regex('HbbTV/([1-9]{1}(\.[0-9]{1}){1,2})')
      user_agent =~ @regex_hbbtv
    end

    def regexes_for_hbbtv
      regexes.select { |r| r[:path] == :'device/televisions.yml' }
    end

    def regexes_other
      regexes.select { |r| r[:path] != :'device/televisions.yml' }
    end

    def parse_regexes(path, raw_regexes)
      raw_regexes.map do |brand, meta|
        fail "invalid device spec: #{meta.inspect}" unless meta[:regex].is_a? String
        meta[:regex] = build_regex(meta[:regex])
        if meta.key?(:models)
          meta[:models].each do |model|
            fail "invalid model spec: #{model.inspect}" unless model[:regex].is_a? String
            model[:regex] = build_regex(model[:regex])
          end
        end
        meta[:path] = path
        meta
      end
    end

  end
end
