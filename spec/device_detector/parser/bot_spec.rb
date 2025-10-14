# frozen_string_literal: true

describe DeviceDetector::Parser::Bot do
  fixture_dir = File.expand_path('../../fixtures/detector', __dir__)
  fixtures = load_fixtures(Dir["#{fixture_dir}/bots.yml"])

  subject { DeviceDetector.new(user_agent, headers) }

  fixtures.each do |f|
    describe f['user_agent'] do
      let(:user_agent) { f['user_agent'] }
      let(:headers) { f['headers'] }

      it 'should have the expected bot data' do
        expect(subject.bot?).to eq(true)
        expect(subject.bot_name).to eq(f['bot']['name'])
      end
    end
  end
end
