# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixtures = load_fixtures('client/*.yml')
  fixtures.each do |f|
    describe [f['user_agent'], f['headers']].compact.join(' / ') do
      let(:user_agent) { f['user_agent'] }
      let(:headers) { f['headers'] }

      let(:client_result) { subject.send(:client_result) }
      let(:client) { normalize_fixture(f['client']) }

      it 'should be known' do
        expect(subject.known?).to eq true
      end

      it 'should have expected name' do
        expect(subject.name).to eq client[:name]
      end

      it 'should have expected version', if: client_version?(f) do
        expect(subject.full_version.to_s).to eq client[:version]
      end

      it 'should have client as in fixture' do
        expect(client_result).to include(client)
      end
    end
  end
end
