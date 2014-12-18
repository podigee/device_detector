require 'spec_helper'

RSpec.describe DeviceDetector::ClientDetector do

  subject(:detector) { DeviceDetector::ClientDetector.new(user_agent) }
  let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }

  describe '#call' do

    it 'returns a DeviceDetector::Client' do
      expect(detector.call).to be_a(DeviceDetector::Client)
    end

    it 'returns the correct name' do
      expect(detector.call.name).to eq('Chrome')
    end

  end

end
