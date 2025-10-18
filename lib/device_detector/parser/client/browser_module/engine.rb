# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Client
      module BrowserModule
        class Engine < AbstractClientParser
          # https://github.com/matomo-org/device-detector/blob/master/Parser/Client/Browser/Engine.php#L39-L60
          BROWSER_ENGINES = %w[
            WebKit
            Blink
            Trident
            Text-based
            Dillo
            iCab
            Elektra
            Presto
            Clecko
            Gecko
            KHTML
            NetFront
            Edge
            NetSurf
            Servo
            Goanna
            EkiohFlow
            Arachne
            LibWeb
            Maple
          ].freeze

          DOWNCASED_BROWSER_ENGINES = BROWSER_ENGINES.map(&:downcase).freeze

          def parse
            parsed = super.dup

            return { engine: '' } if parsed.nil?

            { engine: parsed[:name] } if DOWNCASED_BROWSER_ENGINES.include?(parsed[:name].downcase)
          end

          protected

          def fixture_file
            'regexes/client/browser_engine.yml'
          end

          def parser_name
            'browserengine'
          end
        end
      end
    end
  end
end
