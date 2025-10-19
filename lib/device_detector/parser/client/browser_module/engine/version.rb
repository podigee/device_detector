# frozen_string_literal: true

require 'device_detector/parser/client/hint/browser_hints'

class DeviceDetector
  module Parser
    module Client
      module BrowserModule
        class EngineVersion < AbstractClientParser
          attr_reader :user_agent, :engine

          def use(uas, engine)
            @user_agent = uas
            @engine = engine
          end

          def parse
            return {} if engine && engine.empty?

            if %w[Gecko Clecko].include?(engine)
              pattern = %r{rv[: ]([0-9]+(?:\.[0-9]+)*)(?:[a-z]\d*)?.*(?:g|cl)ecko/[0-9]{8,10}}i

              if (matches = @user_agent.match(pattern))
                return { version: matches[1] }
              end
            end

            engine_token = engine.dup

            engine_token = 'Chr[o0]me|Chromium|Cronet' if engine == 'Blink'
            engine_token = 'Arachne\/5\.' if engine == 'Arachne'
            engine_token = 'LibWeb\+LibJs' if engine == 'LibWeb'
            engine_token = 'Chr[o0]me|Chromium|Cronet' if engine == 'Blink'

            matches = @user_agent.match(%r{(?:#{engine_token})\s*[/_]?\s*(\d+(?:\.\d+)*|\d{1,7})(?=\D|$)}i)

            { version: matches.to_a.last }
          end

          protected

          def parser_name
            'engine version'
          end
        end
      end
    end
  end
end
