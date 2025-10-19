# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Device
      class Notebook < AbstractDeviceParser
        def initialize
          super
          @notebook_regex = build_regex_for_ua('FBMD/')
        end

        def parse
          return nil unless match_user_agent_r(@notebook_regex)

          super
        end

        protected

        def fixture_file
          'device/notebooks.yml'
        end

        def parser_name
          'notebook'
        end
      end
    end
  end
end
