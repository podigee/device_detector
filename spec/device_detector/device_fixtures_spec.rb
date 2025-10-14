# frozen_string_literal: true

require_relative '../spec_helper'

describe DeviceDetector do
  fixture_dir = File.expand_path('../fixtures/device', __dir__)
  fixtures = load_fixtures(Dir["#{fixture_dir}/*.yml"])

  subject { described_class.new(user_agent, headers) }

  fixtures.each do |f|
    let(:user_agent) { f['user_agent'] }
    let(:headers) { f['headers'] }
    let(:device) { f['device'] }

    describe f['user_agent'] do
      it 'should be known' do
        expect(subject).to be_known
      end

      it 'should have the expected model' do
        expect(subject.device_name).to eq str_or_nil(device['model'])
      end

      it 'should have the expected brand' do
        expect(subject.device_brand).to eq device['brand']
      end

      it 'should have the expected type' do
        expect(subject.device_type).to eq device['type']
      end
    end
  end
end
