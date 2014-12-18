require 'spec_helper'

RSpec.describe DeviceDetector do

  subject(:detector) { DeviceDetector.new(user_agent) }

  describe '#os' do

    let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }

    it 'returns the correct operating system' do
      expect(detector.os).to be_a(DeviceDetector::OS)
      expect(detector.os.name).to eq('Mac')
    end

  end

  describe '#client' do

    it 'returns the correct client' do
      expect(detector.client).to be_a(DeviceDetector::Client)
      expect(detector.client.name).to eq('Chrome')
    end

  end

end
