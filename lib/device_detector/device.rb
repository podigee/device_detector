class DeviceDetector
  class Device < Parser

    def known?
      regex_meta.any?
    end

    def name
      ModelExtractor.new(user_agent, regex_meta).call
    end

    def device_type
      regex_meta['device']
    end

    private

    def filenames
      [
        'devices/mobiles.yml'
      ]
    end

    # Overwrite the default parser handling logic
    def self.regexes_for(filepaths)
      @regexes ||=
        begin
          regexes = YAML.load(filepaths.map { |filepath| File.read(filepath) }.join)

          recursive_regex_parser(regexes)
        end
    end

    def self.recursive_regex_parser(nested_regex)
      nested_regex.map { |base, nest|

        if !nest.nil? && nest.include?('models')
          recursive_regex_parser nest['models']
        else
          case base.class.to_s
            when 'Hash'
              base['regex'] = Regexp.new base['regex']
              base
            else
              nest['regex'] = Regexp.new nest['regex']
              nest
          end
        end

      }.flatten
    end

  end
end
