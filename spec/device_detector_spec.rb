require_relative 'spec_helper'

describe DeviceDetector do

  subject { DeviceDetector.new(user_agent) }

  alias :client :subject

  describe 'known user agent' do

    describe 'desktop chrome browser' do

      let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }

      describe '#name' do

        it 'returns the name' do
          client.name.must_equal 'Chrome'
        end

      end

      describe '#full_version' do

        it 'returns the full version' do
          client.full_version.must_equal '30.0.1599.69'
        end

      end

      describe '#os_name' do

        it 'returns the operating system name' do
          client.os_name.must_equal 'Mac'
        end

      end

      describe '#os_full_version' do

        it 'returns the operating system full version' do
          client.os_full_version.must_equal '10.8.5'
        end

      end

      describe '#known?' do

        it 'returns true' do
          client.known?.must_equal true
        end

      end

      describe '#bot?' do

        it 'returns false' do
          client.bot?.must_equal false
        end

      end

      describe '#bot_name' do

        it 'returns nil' do
          client.bot_name.must_be_nil
        end

      end

    end

  end

  describe 'unknown user agent' do

    let(:user_agent) { 'garbage123' }

    describe '#name' do

      it 'returns nil' do
        client.name.must_be_nil
      end

    end

    describe '#full_version' do

      it 'returns nil' do
        client.full_version.must_be_nil
      end

    end

    describe '#os_name' do

      it 'returns nil' do
        client.os_name.must_be_nil
      end

    end

    describe '#os_full_version' do

      it 'returns nil' do
        client.os_full_version.must_be_nil
      end

    end

    describe '#known?' do

      it 'returns false' do
        client.known?.must_equal false
      end

    end

    describe '#bot?' do

      it 'returns false' do
        client.bot?.must_equal false
      end

    end

    describe '#bot_name' do

      it 'returns nil' do
        client.bot_name.must_be_nil
      end

    end

  end

  describe 'bot' do

    let(:user_agent) { 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)' }

    describe '#name' do

      it 'returns nil' do
        client.name.must_be_nil
      end

    end

    describe '#full_version' do

      it 'returns nil' do
        client.full_version.must_be_nil
      end

    end

    describe '#os_name' do

      it 'returns nil' do
        client.os_name.must_be_nil
      end

    end

    describe '#os_full_version' do

      it 'returns nil' do
        client.os_full_version.must_be_nil
      end

    end

    describe '#known?' do

      it 'returns false' do
        client.known?.must_equal false
      end

    end

    describe '#bot?' do

      it 'returns true' do
        client.bot?.must_equal true
      end

    end

    describe '#bot_name' do

      it 'returns the name of the bot' do
        client.bot_name.must_equal 'Googlebot'
      end

    end

  end
end
