# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixtures = load_fixtures('client/*.yml').first(600)
  fixtures.each do |f|
    describe f['user_agent'] do
      let(:fixture) { f }

      let(:user_agent) { f['user_agent'] }
      let(:headers) { f['headers'] }
      let(:client) { f['client'] }
      let(:client_result) { subject.send(:client_result) }

      it 'should be known' do
        expect(subject.known?).to eq true
      end

      it 'should have expected name' do
        expect(subject.name).to eq client['name']
      end
    end
  end
end
