require 'spec_helper'

RSpec.describe DeviceDetector::OS do

  subject(:os) { DeviceDetector::OS.new(regex_meta) }

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

end
