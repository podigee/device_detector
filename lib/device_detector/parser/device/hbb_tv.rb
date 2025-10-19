# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class HbbTv < AbstractDeviceParser
        def initialize
          super
          @hbb_regex = build_regex_for_ua('(?:HbbTV|SmartTvA)/([1-9]{1}(?:\.[0-9]{1}){1,2})')
        end

        def parse
          return nil unless hbb_tv?

          super

          @device_type = 'tv' if @device_type.nil?

          result
        end

        protected

        def fixture_file
          'device/televisions.yml'
        end

        def parser_name
          'tv'
        end

        def hbb_tv?
          match_user_agent_r(@hbb_regex)
        end
      end
    end
  end
end
