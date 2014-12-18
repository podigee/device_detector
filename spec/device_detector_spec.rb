require 'spec_helper'

RSpec.describe DeviceDetector do

  subject(:client) { DeviceDetector.new(user_agent) }

  context 'known user agent' do

    let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }

    describe '#name' do

      it 'returns the name' do
        expect(client.name).to eq('Chrome')
      end

    end

    describe '#full_version' do

      it 'returns the full version' do
        expect(client.full_version).to eq('30.0.1599.69')
      end

    end

    describe '#os_name' do

      it 'returns the operating system name' do
        expect(client.os_name).to eq('Mac')
      end

    end

    describe '#os_full_version' do

      it 'returns the operating system full version' do
        expect(client.os_full_version).to eq('10_8_5')
      end

    end

    describe '#known?' do

      it 'returns true' do
        expect(client.known?).to eq(true)
      end

    end

  end

  context 'unknown user agent' do

    let(:user_agent) { 'garbage123' }

    describe '#name' do

      it 'returns nil' do
        expect(client.name).to be_nil
      end

    end

    describe '#full_version' do

      it 'returns nil' do
        expect(client.full_version).to be_nil
      end

    end

    describe '#os_name' do

      it 'returns nil' do
        expect(client.os_name).to be_nil
      end

    end

    describe '#os_full_version' do

      it 'returns nil' do
        expect(client.os_full_version).to be_nil
      end

    end

    describe '#known?' do

      it 'returns false' do
        expect(client.known?).to eq(false)
      end

    end

  end
end
