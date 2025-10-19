# frozen_string_literal: true

describe DeviceDetector do
  subject { described_class.new(user_agent) }

  alias_method :client, :subject

  describe '.root' do
    it 'returns gem root directory' do
      expect(described_class.root).to eq File.expand_path('..', __dir__)
    end
  end

  describe '.regexes_dir' do
    it 'returns gem regexes directory' do
      expect(described_class.regexes_dir).to eq File.expand_path('../regexes', __dir__)
    end
  end

  describe '.parser_classes' do
    let(:parser_classes) do
      [
        described_class::Parser::Client::FeedReader,
        described_class::Parser::Client::MobileApp,
        described_class::Parser::Client::MediaPlayer,
        described_class::Parser::Client::Pim,
        described_class::Parser::Client::Browser,
        described_class::Parser::Client::Library,
        described_class::Parser::Device::HbbTv,
        described_class::Parser::Device::ShellTv,
        described_class::Parser::Device::Notebook,
        described_class::Parser::Device::Console,
        described_class::Parser::Device::CarBrowser,
        described_class::Parser::Device::Camera,
        described_class::Parser::Device::PortableMediaPlayer,
        described_class::Parser::Device::Mobile,
        described_class::Parser::Bot
      ]
    end

    it 'returns parser classes' do
      expect(described_class.parser_classes).to eq parser_classes
    end
  end

  describe 'known user agent' do
    describe 'desktop chrome browser' do
      let(:user_agent) do
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69'
      end

      describe '#name' do
        it 'returns the name' do
          expect(client.name).to eq 'Chrome'
        end
      end

      describe '#full_version' do
        it 'returns the full version' do
          expect(client.full_version).to eq '30.0.1599.69'
        end
      end

      describe '#os_family' do
        it 'returns the operating system name' do
          expect(client.os_family).to eq 'Mac'
        end
      end

      describe '#os_name' do
        it 'returns the operating system name' do
          expect(client.os_name).to eq 'Mac'
        end
      end

      describe '#os_full_version' do
        it 'returns the operating system full version' do
          expect(client.os_full_version).to eq '10.8.5'
        end
      end

      describe '#known?' do
        it 'returns true' do
          expect(client.known?).to be true
        end
      end

      describe '#bot?' do
        it 'returns false' do
          expect(client.bot?).to be false
        end
      end

      describe '#bot_name' do
        it 'returns nil' do
          expect(client.bot_name).to be_nil
        end
      end
    end

    describe 'ubuntu linux' do
      let(:user_agent) do
        'Mozilla/5.0 (X11; Ubuntu; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36'
      end

      describe '#os_family' do
        it 'returns the operating system name' do
          expect(client.os_family).to eq 'GNU/Linux'
        end
      end

      describe '#os_name' do
        it 'returns the operating system name' do
          expect(client.os_name).to eq 'Ubuntu'
        end
      end
    end

    describe 'firefox mobile phone' do
      let(:user_agent) { 'Mozilla/5.0 (Android 7.0; Mobile; rv:53.0) Gecko/53.0 Firefox/53.0' }

      it 'detects smartphone' do
        expect(client.device_type).to eq 'smartphone'
      end
    end

    describe 'firefox mobile tablet' do
      let(:user_agent) { 'Mozilla/5.0 (Android 6.0.1; Tablet; rv:47.0) Gecko/47.0 Firefox/47.0' }

      it 'detects tablet' do
        expect(client.device_type).to eq 'tablet'
      end
    end
  end

  describe 'unknown user agent' do
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
        expect(client.known?).to be false
      end
    end

    describe '#bot?' do
      it 'returns false' do
        expect(client.bot?).to be false
      end
    end

    describe '#bot_name' do
      it 'returns nil' do
        expect(client.bot_name).to be_nil
      end
    end
  end

  describe 'user agent is nil' do
    let(:user_agent) { nil }

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
        expect(client.known?).to be false
      end
    end

    describe '#bot?' do
      it 'returns false' do
        expect(client.bot?).to be false
      end
    end

    describe '#bot_name' do
      it 'returns nil' do
        expect(client.bot_name).to be_nil
      end
    end
  end

  describe 'wrongly encoded user agent' do
    let(:user_agent) { 'Mon User-Agent personnalisé'.dup.force_encoding('ASCII-8BIT') }

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
        expect(client.known?).to be false
      end
    end

    describe '#bot?' do
      it 'returns false' do
        expect(client.bot?).to be false
      end
    end

    describe '#bot_name' do
      it 'returns nil' do
        expect(client.bot_name).to be_nil
      end
    end
  end

  describe 'bot' do
    let(:user_agent) { 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)' }

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
        expect(client.known?).to be false
      end
    end

    describe '#bot?' do
      it 'returns true' do
        expect(client.bot?).to be true
      end
    end

    describe '#bot_name' do
      it 'returns the name of the bot' do
        expect(client.bot_name).to eq 'Googlebot'
      end
    end
  end
end
