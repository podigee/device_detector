# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent) }

  alias_method :client, :subject

  describe 'mobile iPhone 5S' do
    let(:user_agent) do
      'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B440 [FBDV/iPhone6,1]'
    end

    describe '#device_name' do
      it 'returns device name' do
        expect(client.device_name).to eq 'iPhone 5S'
      end
    end

    describe '#device_type' do
      it 'returns the device type' do
        expect(client.device_type).to eq 'smartphone'
      end
    end
  end

  describe 'Ubuntu 10' do
    let(:user_agent) do
      'Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Ubuntu/10.10 Chromium/10.0.648.133 Chrome/10.0.648.133 Safari/534.16'
    end

    describe '#os_name' do
      it 'returns the OS name' do
        expect(client.os_name).to eq 'Ubuntu'
      end
    end
  end

  describe 'Mac OS X' do
    let(:user_agent) do
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36'
    end

    describe '#full_version' do
      it 'returns the correct OS version' do
        expect(client.os_full_version).to eq '10.10.1'
      end
    end
  end

  describe 'Chrome on Windows' do
    describe '32bit' do
      let(:user_agent) do
        'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.103 Safari/537.36'
      end

      it 'returns the correct client name' do
        expect(client.name).to eq 'Chrome'
      end

      it 'recognizes the device name' do
        expect(client.device_name).to be nil
      end

      it 'recognizes the device type' do
        expect(client.device_type).to eq 'desktop'
      end
    end

    describe '64bit' do
      let(:user_agent) do
        'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'
      end

      it 'returns the correct client name' do
        expect(client.name).to eq 'Chrome'
      end

      it 'recognizes the device name' do
        expect(client.device_name).to be nil
      end

      it 'recognizes the device type' do
        expect(client.device_type).to eq 'desktop'
      end
    end
  end

  describe 'recognize and ignore sprd- prefix' do
    let(:user_agent) do
      'sprd-Galaxy-S5/1.0 Linux/2.6.35.7 Android/4.4.4 Release/11.29.2014 Browser/AppleWebKit533.1 (KHTML, like Gecko) Mozilla/5.0 Mobile'
    end

    it 'returns the correct client name' do
      expect(client.name).to eq 'Android Browser'
    end

    it 'recognizes the device name' do
      expect(client.device_name).to eq 'Galaxy S5'
    end

    it 'recognizes the device type' do
      expect(client.device_type).to eq 'smartphone'
    end
  end

  describe 'remove TD suffix from model' do
    let(:user_agent) do
      'Lenovo-A398t+_TD/S100 Linux/3.4.5 Android/4.1.2 Release/09.10.2013 Browser/AppleWebKit534.30 Mobile Safari/534.30'
    end

    it 'returns the correct client name' do
      expect(client.name).to eq 'Android Browser'
    end

    it 'recognizes the device name' do
      expect(client.device_name).to eq 'A398t+'
    end

    it 'recognizes the device type' do
      expect(client.device_type).to eq 'smartphone'
    end
  end
end
