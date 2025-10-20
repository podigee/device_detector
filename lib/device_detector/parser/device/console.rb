# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class Console < AbstractDeviceParser
        def parse
          return nil unless pre_match_overall?

          super
        end

        protected

        def fixture_file
          'device/consoles.yml'
        end

        def parser_name
          'console'
        end
      end
    end
  end
end
