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

end

