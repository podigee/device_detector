# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixtures = load_fixtures('client/*.yml')
  fixtures.each do |f|
    describe [f['user_agent'], f['headers']].compact.join(' / ') do
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

      it 'should have expected version', if: client_version?(f) do
        expect(subject.full_version).to eq client['version'].to_s
      end

      it 'should have expected type' do
        expect(client_result[:type]).to eq client['type']
      end

      it 'should have expected engine', if: client_engine?(f) do
        expect(client_result[:engine]).to eq client['engine']
      end

      it 'should have expected engine version', if: client_engine_version?(f) do
        expect(client_result[:engine_version]).to eq client['engine_version']
      end

      it 'should have expected family', if: client_family?(f) do
        expect(client_result[:family]).to eq client['family']
      end
    end
  end
end
