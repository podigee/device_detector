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

    def self.parse_regexes(regexes)
      regexes.map { |base, nest|

        if !nest.nil? && nest.key?('models')
          parse_regexes nest['models']
        else
          case base
          when Hash
            base['regex'] = Regexp.new base['regex']
            base
          when String
            nest['regex'] = Regexp.new nest['regex']
            nest
          else
            fail "#{filenames.join(', ')} regexes are either malformed or format has changes."
          end
        end

      }.flatten
    end

  end
end
