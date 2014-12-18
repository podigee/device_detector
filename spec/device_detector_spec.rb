require 'spec_helper'

RSpec.describe DeviceDetector do

  subject(:detector) { DeviceDetector.new(nil) }

  describe '#os' do

    it 'returns a DeviceDetector::OS' do
      expect(detector.os).to be_a(DeviceDetector::OS)
    end

  end

  describe '#client' do

    it 'returns a DeviceDetector::Client' do
      expect(detector.client).to be_a(DeviceDetector::Client)
    end

  end

end
