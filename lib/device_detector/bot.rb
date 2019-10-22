class DeviceDetector
  class Bot < Parser

    def bot?
      regex_meta.any?
    end

    private

    def filenames
      ['bots.yml']
    end

    def regexes_for(file_paths)
      super + [google_regex]
    end

    def google_regex
      {
        name: 'Googlebot',
        path: 'DeviceDetector::Bot',
        regex: /.*support\.google\.com.*/
      }.freeze
    end


  end
end
