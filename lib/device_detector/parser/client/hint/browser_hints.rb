# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Client
      module Hint
        class BrowserHints < AbstractParser
          def fixture_file
            'regexes/client/hints/browsers.yml'
          end

          def parser_name
            'BrowserHints'
          end

          def parse
            return nil unless @client_hints

            app_id = @client_hints.app
            return nil if app_id.nil?

            name = regexes[app_id]
            return nil if name == ''

            { name: name }
          end
        end
      end
    end
  end
end
