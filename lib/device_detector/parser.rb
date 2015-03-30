class DeviceDetector
  class Parser < Struct.new(:user_agent)

    ROOT = File.expand_path('../../..', __FILE__)

    def name
      NameExtractor.new(user_agent, regex_meta).call
    end

    def full_version
      VersionExtractor.new(user_agent, regex_meta).call
    end

    private

    def regex_meta
      @regex_meta ||= matching_regex || {}
    end

    def matching_regex
      DeviceDetector.cache.get_or_set([self.class.name, user_agent]) do
        regexes.find { |r| user_agent =~ r['regex'] }
      end
    end

    def regexes
      @regexes ||= regexes_for(filepaths)
    end

    def filenames
      fail NotImplementedError
    end

    def filepaths
      filenames.map do |filename|
        File.join(ROOT, 'regexes', filename)
      end
    end

    def regexes_for(filepaths)
      DeviceDetector.cache.get_or_set(['regexes', self.class]) do
        begin
          raw_regexes = load_regexes
          parsed_regexes = raw_regexes.map { |r| parse_regexes(r) }

          parsed_regexes.flatten
        end
      end
    end

    def load_regexes
      raw_files = filepaths.map { |path| File.read(path) }

      raw_files.map { |f| YAML.load(f) }
    end

    def parse_regexes(raw_regexes)
      raw_regexes.map do |meta|
        meta['regex'] = Regexp.new(meta['regex']) if meta['regex'].is_a? String
        meta
      end
    end

  end
end
