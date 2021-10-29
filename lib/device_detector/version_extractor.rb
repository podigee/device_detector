# frozen_string_literal: true

class DeviceDetector
  class VersionExtractor < MetadataExtractor
    MAJOR_VERSION_2 = Gem::Version.new('2.0')
    MAJOR_VERSION_3 = Gem::Version.new('3.0')
    MAJOR_VERSION_4 = Gem::Version.new('4.0')
    MAJOR_VERSION_8 = Gem::Version.new('8.0')

    def call
      super&.chomp('.')
    end

    private

    def metadata_string
      String(regex_meta[:version])
    end
  end
end
