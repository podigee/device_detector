require 'spec_helper'

RSpec.describe DeviceDetector::Client do

  subject(:client) { DeviceDetector::Client.new(regex_meta) }

  let(:regex_meta) do
    {
      'regex' => 'Firefox(?:/(\d+[\.\d]+))?',
      'name' => 'Firefox',
      'version' => '$1',
      'engine' => {
        'default' => 'Gecko'
      }
    }
  end

  describe '#name' do

    it 'returns the correct name' do
      expect(client.name).to eq('Firefox')
    end

  end

end
