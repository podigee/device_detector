# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class Mobile < AbstractDeviceParser
        protected

        def fixture_file
          'device/mobiles.yml'
        end

        def parser_name
          'mobile'
        end
      end
    end
  end
end
