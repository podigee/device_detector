require_relative '../spec_helper'

describe DeviceDetector::Bot do

  fixture_dir = File.expand_path('../../fixtures/parser', __FILE__)
  fixture_files = Dir["#{fixture_dir}/bots.yml"]
  fixture_files.each do |fixture_file|

    describe File.basename(fixture_file) do

      fixtures = YAML.load_file(fixture_file)

      fixtures.each do |f|
        user_agent = f["user_agent"]
        bot = DeviceDetector::Bot.new(user_agent)

        describe user_agent do
          it "should be a bot" do
            assert bot.bot?, "isn't a bot"
          end

          it "should have the expected name" do
            assert_equal f["bot"]["name"], bot.name, "failed bot name detection"
          end
        end

      end
    end
  end

  describe 'Googlebots' do
    it 'detects any googlebot' do
      user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 '+
        '(KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 '+
        '(compatible; Google-Something-Something; '+
        '+https://support.google.com/webmasters/answer/1061943)'
      bot = DeviceDetector::Bot.new(user_agent)
      assert bot.bot?, "isn't a bot"
      assert_equal 'Googlebot', bot.name, "failed bot name detection"
    end
  end
end
