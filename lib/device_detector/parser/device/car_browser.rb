# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class CarBrowser < AbstractDeviceParser
        def parse
          return nil unless pre_match_overall?

          super
        end

        protected

        def fixture_file
          'device/car_browsers.yml'
        end

        def parser_name
          'car browser'
        end
      end
    end
  end
end
