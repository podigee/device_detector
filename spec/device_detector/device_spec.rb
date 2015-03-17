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

    context 'device not specified in nested block' do

      let(:user_agent) { 'Mozilla/5.0 (Linux; Android 4.4.2; es-us; SAMSUNG SM-G900F Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko)' }

      it 'falls back to top-level device' do
        expect(device.type).to eq('smartphone')
      end

    end

  end

  context 'concrete device types' do

    describe 'mobiles' do

      let(:user_agent) { 'Mozilla/5.0 (Linux; Android 4.4.2; es-us; SAMSUNG SM-G900F Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko)' }

      it 'identifies the device' do
        expect(device.name).to eq('GALAXY S5')
        expect(device.type).to eq('smartphone')
      end

    end

    describe 'cameras' do

      let(:user_agent) { 'Mozilla/5.0 (Linux; U; Android 4.0; xx-xx; EK-GC100 Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30' }

      it 'identifies the device' do
        expect(device.name).to eq('GALAXY Camera')
        expect(device.type).to eq('camera')
      end

    end

    describe 'car browsers' do

      let(:user_agent) { 'Mozilla/5.0 (X11; Linux) AppleWebKit/534.34 (KHTML, like Gecko) QtCarBrowser Safari/534.34' }

      it 'identifies the device' do
        expect(device.name).to eq('Model S')
        expect(device.type).to eq('car browser')
      end

    end

    describe '(gaming) consoles' do

      let(:user_agent) { 'Opera/9.30 (Nintendo Wii; U; ; 2047-7;en)' }

      it 'identifies the device' do
        expect(device.name).to eq('Wii')
        expect(device.type).to eq('console')
      end

    end

    describe 'portable media players' do

      let(:user_agent) { 'Mozilla/5.0 (iPod touch; CPU iPhone OS 7_0_6 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11B651 Safari/9537.53' }

      it 'identifies the device' do
        expect(device.name).to eq('iPod Touch')
        expect(device.type).to eq('portable media player')
      end

    end

    describe 'televisions' do

      let(:user_agent) { 'Mozilla/5.0 (Linux; NetCast; U) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.33 Safari/537.31 SmartTV/5.0' }

      it 'identifies the device' do
        expect(device.name).to eq('NetCast')
        expect(device.type).to eq('tv')
      end

    end
  end

end
