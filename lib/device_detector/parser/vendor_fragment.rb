# frozen_string_literal: true

class DeviceDetector
  module Parser
    class VendorFragment < AbstractParser
      def use(uas)
        self.user_agent = uas
      end

      def parse
        regex_from_user_agent_cache do
          brand, = regexes.detect do |brand, many_regexes|
            many_regexes.detect do |regex|
              # perf: the additional suffex needed here will be added in
              # prepare_definition_for_cache already
              break brand if match_user_agent_r(regex)
            end
          end

          brand
        end
      end

      protected

      # overriden from AbstractParser
      def prepare_definition_for_cache(definition)
        definition.map { |s| build_regex_for_ua(s + '[^a-z0-9]+') }
      end

      def fixture_file
        'vendorfragments.yml'
      end

      def parser_name
        'vendorfragments'
      end
    end
  end
end
