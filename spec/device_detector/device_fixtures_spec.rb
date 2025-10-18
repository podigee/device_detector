# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent, headers) }

  fixtures = load_fixtures('device/*.yml')
  fixtures.each do |f|
    describe f['user_agent'] do
      let(:fixture) { f }

      let(:user_agent) { f['user_agent'] }
      let(:headers) { f['headers'] }
      let(:device) { f['device'] }

      it 'should be known' do
        expect(subject).to be_known
      end

      it 'should have the expected model', if: device_model?(f) do
        expect(subject.device_name).to eq device['model']
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
