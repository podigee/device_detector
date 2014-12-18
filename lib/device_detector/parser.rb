class DeviceDetector
  class Parser < Struct.new(:user_agent)

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
      regexes.find { |r| user_agent =~ Regexp.new(r['regex']) }
    end

    def regexes
      self.class.regexes_for(filepaths)
    end

    def filenames
      fail NotImplementedError
    end

    def filepaths
      filenames.map do |filename|
        File.join(root, 'regexes', filename)
      end
    end

    def root
      Pathname.new(File.expand_path('../../..', __FILE__))
    end

    # This is a performance optimization.
    # We cache the regexes on the class for better performance
    # Thread-safety shouldn't be an issue, as we do only perform reads
    def self.regexes_for(filepaths)
      @regexes ||= YAML.load(filepaths.map { |filepath| File.read(filepath) }.join)
    end

  end
end
