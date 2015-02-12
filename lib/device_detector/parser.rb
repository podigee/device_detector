class DeviceDetector
  class Parser < Struct.new(:user_agent)

    ROOT = File.expand_path('../../..', __FILE__)

    def name
      regex_meta['name']
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
      self.class.regexes_for(filepaths)
    end

    def filenames
      fail NotImplementedError
    end

    def filepaths
      filenames.map do |filename|
        File.join(ROOT, 'regexes', filename)
      end
    end

    # This is a performance optimization.
    # We cache the regexes on the class for better performance
    # Thread-safety shouldn't be an issue, as we do only perform reads
    def self.regexes_for(filepaths)
      @regexes ||=
        begin
          regexes = YAML.load(filepaths.map { |filepath| File.read(filepath) }.join)
          regexes.map do |meta|
            meta['regex'] = Regexp.new(meta['regex'])
            meta
          end
        end
    end

  end
end
