require 'spec_helper'

describe DeviceDetector do

  subject { DeviceDetector.new(user_agent) }

  alias :client :subject

  describe 'mobile iPhone 5S' do

    let(:user_agent) { 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B440 [FBDV/iPhone6,1]' }

    describe '#device_name' do

      it 'returns device name' do
        client.device_name.must_equal 'iPhone 5S'
      end

    end

    describe '#device_type' do

      it 'returns the device type' do
        client.device_type.must_equal 'smartphone'
      end

    end

  end

  describe 'Ubuntu 10' do

    let(:user_agent) { 'Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Ubuntu/10.10 Chromium/10.0.648.133 Chrome/10.0.648.133 Safari/534.16' }

    describe '#os_name' do

      it 'returns the OS name' do
        client.os_name.must_equal 'Ubuntu'
      end

    end

  end

  describe 'Mac OS X' do

    let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36' }

    describe '#full_version' do

      it 'returns the correct OS version' do
        client.os_full_version.must_equal '10.10.1'
      end

    end

  end

  describe 'Windows 8' do

    let(:user_agent) { 'Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko' }

    describe 'Internet Explorer 11' do

      it 'IE 11 is not a TV on Windows 8 !' do
        client.device_type.must_equal nil
      end

    end

  end

end

