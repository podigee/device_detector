# frozen_string_literal: true

require_relative '../spec_helper'

describe DeviceDetector do
  fixture_dir = File.expand_path('../fixtures/detector', __dir__)
  fixtures = load_fixtures(Dir["#{fixture_dir}/*.yml"])

  subject { described_class.new(user_agent, headers) }

  fixtures.each do |f|
    describe f['user_agent'] do
      let(:fixture) { f }
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

        # it 'should detect client version' do
        #   pending 'TODO: Implement browser engine and family parsing '
        #   expect(subject.full_version).to eq client['version']
        # end

        it 'should detect client short name' do
          expect(client_result['short_name']).to eq client['short_name']
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

        it 'should detect expected device model' do
          expect(subject.device_name).to eq str_or_nil(device['model'])
        end
      end
    end
  end
end
