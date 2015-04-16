class DeviceDetector
  class Device < Parser

    def known?
      regex_meta.any?
    end

    def name
      ModelExtractor.new(user_agent, regex_meta).call
    end

    def type
      regex_meta['device']
    end

    private

    # The order of files is relevant.
    # portable_media_players has to come before mobiles because of devices like the iPod
    # which would otherwise be detected as iPhones
    # televisions.yml works best at the end
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

    def parse_regexes(raw_regexes, device = nil)
      raw_regexes.map { |base, nest|

        if !nest.nil? && nest.key?('models')
          default_device = nest['device']
          parse_regexes(nest['models'], default_device)
        else
          regex =
            case base
            when Hash
              base
            when String
              nest
            else
              fail "#{filenames.join(', ')} regexes are either malformed or format has changes."
            end

          regex['device'] ||= device
          regex['regex'] = Regexp.new(regex['regex'])

          regex
        end

      }.flatten
    end

  end
end
