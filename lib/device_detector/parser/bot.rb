# frozen_string_literal: true

class DeviceDetector
  module Parser
    class Bot < AbstractParser
      def parser_type
        :bot
      end

      def parse
        regex_from_user_agent_cache do
          pre_match_overall? && regexes.detect do |regex|
            match_user_agent_r(regex[:regex])
          end
        end
      end

      protected

      def fixture_file
        'bots.yml'
      end

      def parser_name
        'bot'
      end
    end
  end
end
