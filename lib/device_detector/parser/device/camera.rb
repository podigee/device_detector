# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class Camera < AbstractDeviceParser
        def parse
          return nil unless pre_match_overall?

          super
        end

        protected

        def fixture_file
          'device/cameras.yml'
        end

        def parser_name
          'camera'
        end
      end
    end
  end
end
