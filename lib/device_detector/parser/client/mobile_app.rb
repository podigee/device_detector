# frozen_string_literal: true

require 'device_detector/parser/client/hint/app_hints'

class DeviceDetector
  module Parser
    module Client
      class MobileApp < AbstractClientParser
        def initialize
          super
          @app_hints = DeviceDetector::Parser::Client::Hint::AppHints.new
        end

        def use(uas, hints)
          super
          @app_hints.use(uas, hints)
        end

        def parse
          result = super
          name = result&.fetch(:name) || ''
          version = result&.fetch(:version) || ''
          app_hash = @app_hints.parse

          if !app_hash.nil? && app_hash[:name] != name
            name = app_hash[:name]
            version = ''
          end

          return nil if empty?(name)

          {
            type: parser_name,
            name: name,
            version: version
          }
        end

        protected

        def fixture_file
          'client/mobile_apps.yml'
        end

        def parser_name
          'mobile app'
        end
      end
    end
  end
end
