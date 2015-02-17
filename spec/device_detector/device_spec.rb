require 'spec_helper'

describe DeviceDetector::Device do

  subject(:device) { DeviceDetector::Device.new(user_agent) }

  describe '#name' do

    context 'when models are nested' do
      let(:user_agent) { 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B466 [FBDV/iPhone7,2]' }

      it 'finds an Apple iPhone 6' do
        expect(device.name).to eq('iPhone 6')
      end
    end

    context 'when models are NOT nested' do
      let(:user_agent) { 'AIRNESS-AIR99/REV 2.2.1/Teleca Q03B1' }

      it 'finds an Airness AIR99' do
        expect(device.name).to eq('AIR99')
      end
    end

    context 'when it cannot find a device name' do
      let(:user_agent) { 'UNKNOWN MODEL NAME' }

      it 'returns nil' do
        expect(device.name).to eq(nil)
      end
    end

  end

  describe '#type' do

    context 'when models are nested' do
      let(:user_agent) { 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B466 [FBDV/iPhone7,2]' }

      it 'finds device of Apple iPhone 6' do
        expect(device.type).to eq('smartphone')
      end
    end

    context 'when models are NOT nested' do
      let(:user_agent) { 'AIRNESS-AIR99/REV 2.2.1/Teleca Q03B1' }

      it 'finds the device of Airness AIR99' do
        expect(device.type).to eq('feature phone')
      end
    end

    context 'when it cannot find a device type' do
      let(:user_agent) { 'UNKNOWN MODEL TYPE' }

      it 'returns nil' do
        expect(device.type).to eq(nil)
      end

    end

  end

end
