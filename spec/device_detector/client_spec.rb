require 'spec_helper'

RSpec.describe DeviceDetector::Client do

  subject(:client) { DeviceDetector::Client.new(user_agent, regex_meta) }

  let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }

  let(:regex_meta) do
    {
      'regex' => 'Chrome(?:/(\d+[\.\d]+))?',
      'name' => 'Chrome',
      'version' => '$1'
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

  end
end

