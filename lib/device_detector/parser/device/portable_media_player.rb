# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class PortableMediaPlayer < AbstractDeviceParser
        def parse
          return nil unless pre_match_overall?

          super
        end

        protected

        def fixture_file
          'device/portable_media_player.yml'
        end

        def parser_name
          'portablemediaplayer'
        end
      end
    end
  end
end
