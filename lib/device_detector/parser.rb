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
      YAML.load(filepaths.map { |filepath| File.read(filepath) }.join)
    end

    def filenames
      fail NotImplementedError
    end

    def filepaths
      filenames.map do |filename|
        File.join(DeviceDetector::ROOT, 'regexes', filename)
      end
    end


  end
end
