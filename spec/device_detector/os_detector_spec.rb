require 'spec_helper'

RSpec.describe DeviceDetector::OSDetector do

  subject(:detector) { DeviceDetector::OSDetector.new(user_agent) }
  let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }


  describe '#call' do

    it 'returns a DeviceDetector::OS' do
      expect(detector.call).to be_a(DeviceDetector::OS)
    end

    it 'returns the correct name' do
      expect(detector.call.name).to eq('Mac')
    end

  end

end
