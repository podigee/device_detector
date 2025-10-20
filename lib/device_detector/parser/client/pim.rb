# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Client
      class Pim < AbstractClientParser
        protected

        def fixture_file
          'client/pim.yml'
        end

        def parser_name
          'pim'
        end
      end
    end
  end
end
