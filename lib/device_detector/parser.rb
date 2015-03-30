class DeviceDetector
  class Parser < Struct.new(:user_agent)

    ROOT = File.expand_path('../../..', __FILE__)

    def name
      from_cache(['name', self.class.name, user_agent]) do
        NameExtractor.new(user_agent, regex_meta).call
      end
    end

    def full_version
      from_cache(['full_version', self.class.name, user_agent]) do
        VersionExtractor.new(user_agent, regex_meta).call
      end
    end

    private

    def regex_meta
      @regex_meta ||= matching_regex || {}
    end

    def matching_regex
      from_cache([self.class.name, user_agent]) do
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
      from_cache(['regexes', self.class]) do
        raw_regexes = load_regexes
        parsed_regexes = raw_regexes.map { |r| parse_regexes(r) }

        parsed_regexes.flatten
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

    def from_cache(key)
      DeviceDetector.cache.get_or_set(key) { yield }
    end

  end
end
