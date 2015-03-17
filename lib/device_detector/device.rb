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

    def filenames
      [
        'devices/mobiles.yml'
      ]
    end

    def self.parse_regexes(regexes, device = nil)
      regexes.map { |base, nest|

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
