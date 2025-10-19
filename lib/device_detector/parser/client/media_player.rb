# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Client
      class MediaPlayer < AbstractClientParser
        protected

        def fixture_file
          'client/mediaplayers.yml'
        end

        def parser_name
          'mediaplayer'
        end
      end
    end
  end
end
