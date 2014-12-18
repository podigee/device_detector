require 'spec_helper'

RSpec.describe DeviceDetector::OS do

  subject(:os) { DeviceDetector::OS.new(user_agent, regex_meta) }

  let(:user_agent) { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69' }

  let(:regex_meta) do
    {
      'regex' => 'Mac OS X(?: (?:Version )?(\d+(?:[_\.]\d+)+))?',
      'name' => 'Mac',
      'version' => '$1'
    }
  end

  describe '#name' do

    it 'returns the correct name' do
      expect(os.name).to eq('Mac')
    end

  end

  describe '#full_version' do

    it 'returns the correct version' do
      expect(os.full_version).to eq('10_8_5')
    end

  end

end
