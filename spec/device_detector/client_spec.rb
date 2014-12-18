require 'spec_helper'

RSpec.describe DeviceDetector::Client do

  subject(:client) { DeviceDetector::Client.new(user_agent, regex_meta) }

  let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }

  let(:regex_meta) do
    {
      'regex' => 'Chrome(?:/(\d+[\.\d]+))?',
      'name' => 'Chrome',
      'version' => '$1',
      'engine' => {
        'default' => 'WebKit'
      }
    }
  end

  describe '#name' do

    it 'returns the correct name' do
      expect(client.name).to eq('Chrome')
    end

  end

  describe '#full_version' do

    it 'returns the correct version' do
      expect(client.full_version).to eq('30.0.1599.69')
    end

    context 'client without version' do

      let(:user_agent) { 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; Avant Browser; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0)' }

      let(:regex_meta) do
        {
          'regex' => 'Avant Browser',
          'name' => 'Avant Browser',
          'version' => '',
          'engine' => {
            'default' => '' # multiple
          }
        }
      end

      it 'returns nil' do
        expect(client.full_version).to be_nil
      end

    end

    context 'regex with version $1 ($2)' do

      let(:user_agent) { 'Mozilla/5.0 (X11; U; Linux i686; nl; rv:1.8.1b2) Gecko/20060821 BonEcho/2.0b2 (Debian-1.99+2.0b2+dfsg-1)' }
      let(:regex_meta) do
        {
          'regex' => '(BonEcho|GranParadiso|Lorentz|Minefield|Namoroka|Shiretoko)/(\d+[\.\d]+)',
          'name' => 'Firefox',
          'version' => '$1 ($2)',
          'engine' => {
            'default' => 'Gecko'
          }
        }
      end

      it 'returns the correct version' do
        expect(client.full_version).to eq('BonEcho (2.0)')
      end

    end

  end
end

