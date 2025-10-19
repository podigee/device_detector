# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class ShellTv < AbstractDeviceParser
        def initialize
          super
          @shell_tv_regex = build_regex_for_ua('[a-z]+[ _]Shell[ _]\w{6}|tclwebkit(\d+[.\d]*)')
        end

        def parse
          return nil unless shell_tv?

          super

          @device_type = 'tv'

          result
        end

        protected

        def fixture_file
          'device/shell_tv.yml'
        end

        def parser_name
          'shelltv'
        end

        def shell_tv?
          match_user_agent_r(@shell_tv_regex)
        end
      end
    end
  end
end
