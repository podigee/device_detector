# frozen_string_literal: true

class DeviceDetector
  module Parser
    module Client
      class FeedReader < AbstractClientParser
        protected

        def fixture_file
          'client/feed_readers.yml'
        end

        def parser_name
          'feed reader'
        end
      end
    end
  end
end
