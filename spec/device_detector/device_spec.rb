require 'spec_helper'

describe DeviceDetector::Device do

  subject(:device) { DeviceDetector::Device.new(user_agent) }

  describe '#name' do

    context 'when models are nested' do
      let(:user_agent) { 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B466 [FBDV/iPhone7,2]' }

      it 'should find an Apple iPhone 6' do
        expect(device.name).to eq('iPhone 6')
      end
    end

    context 'when models are NOT nested' do
      let(:user_agent) { 'AIRNESS-AIR99/REV 2.2.1/Teleca Q03B1' }

      it 'should find an Airness AIR99' do
        expect(device.name).to eq('AIR99')
      end
    end

  end

  describe '#device_type' do

    context 'when models are nested' do
      let(:user_agent) { 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B466 [FBDV/iPhone7,2]' }

      it 'should find device of Apple iPhone 6' do
        expect(device.device_type).to eq('smartphone')
      end
    end

    context 'when models are NOT nested' do
      let(:user_agent) { 'AIRNESS-AIR99/REV 2.2.1/Teleca Q03B1' }

      it 'should find the device of Airness AIR99' do
        expect(device.device_type).to eq('feature phone')
      end
    end


  end

end
