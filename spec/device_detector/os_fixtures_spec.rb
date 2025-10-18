# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixtures = load_fixtures('parser/oss.yml')
  fixtures.each do |f|
    describe [f['user_agent'], f['headers']].compact.join(' / ') do
      let(:fixture) { f }

      let(:user_agent) { f['user_agent'] }
      let(:headers) { f['headers'] }
      let(:os) { f['os'] }
      let(:os_result) { subject.send(:os_result) }

      it 'should have the expected OS name' do
        expect(subject.os_name).to eq os['name']
      end

      it 'should have the expected OS version', if: os_version?(f) do
        expect(subject.os_full_version).to eq os['version']
      end

      it 'should have the expected OS family' do
        expect(subject.os_family).to eq os['family']
      end

      it 'should have the expected OS platform', if: os_platform?(f) do
        expect(os_result[:platform]).to eq os['platform']
      end
    end
  end
end
