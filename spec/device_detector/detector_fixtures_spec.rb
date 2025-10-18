# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixtures = load_fixtures('detector/*.yml')
  fixtures.each do |f|
    describe [f['user_agent'], f['headers']].compact.join(' / ') do
      let(:user_agent) { f['user_agent'] }
      let(:headers) { f['headers'] }
      let(:bot) { f['bot'] }
      let(:client) { f['client'] }
      let(:os) { f['os'] }
      let(:device) { f['device'] }

      context 'with bot fixture', if: f['bot'] do
        it 'should detect bot' do
          expect(subject.bot?).to eq true
        end

        it 'should detect bot name' do
          expect(subject.bot_name).to eq bot['name']
        end
      end

      context 'with client fixture', if: f['client'] do
        let(:client_result) { subject.send(:client_result) }

        it 'should detect client name' do
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
      end

      context 'with OS fixture', if: f['os'].is_a?(Hash) do
        let(:os_result) { subject.send(:os_result) }

        it 'should detect expected OS name' do
          expect(subject.os_name).to eq os['name']
        end

        it 'should detect expected OS version' do
          expect(subject.os_full_version).to eq str_or_nil(os['version'])
        end

        it 'should detect expected OS family' do
          expect(subject.os_family).to eq f['os_family']
        end

        it 'should detect expected OS platform' do
          expect(os_result[:platform]).to eq str_or_nil(os['platform'])
        end
      end

      context 'with device fixture', if: f['device'] do
        it 'should detect expected device type' do
          expect(subject.device_type).to eq str_or_nil(device['type'])
        end

        it 'should detect expected device brand' do
          expect(subject.device_brand).to eq str_or_nil(device['brand'])
        end

        it 'should detect expected device model', if: device_model?(f) do
          expect(subject.device_name).to eq device['model']
        end
      end
    end
  end
end
