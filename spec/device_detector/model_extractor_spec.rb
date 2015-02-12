require 'spec_helper'

describe DeviceDetector::ModelExtractor do

  subject(:extractor) { DeviceDetector::ModelExtractor.new(user_agent, regex_meta) }

  describe '#call' do

    context 'when matching against dynamic model' do

      let(:regex_meta) do
        {
          'regex'  => '(?:Apple-)?iPhone ?(3GS?|4S?|5[CS]?|6(:? Plus)?)?',
          'model'  => 'iPhone $1',
          'device' => 'smartphone'
        }
      end

      context 'when no dynamic match is found' do
        let(:user_agent) { 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B466 Safari/600.1.4' }
        let(:device_name) { 'iPhone' }

        it 'should return the textual portion without trailing whitespace' do
          expect(extractor.call).to eq(device_name)
        end

      end

      context 'when a dynamic match is found' do
        let(:user_agent) { 'Mozilla/5.0 (iPhone 5S; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B466 Safari/600.1.4' }
        let(:device_name) { 'iPhone 5S' }

        it 'should return the full device name' do
          expect(extractor.call).to eq(device_name)
        end

      end

    end

    context 'when matching against static model' do

      let(:user_agent) { 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12A365 Weibo (iPhone7,2)' }
      let(:device_name) { 'iPhone 6' }
      let(:regex_meta) do
        {
          'regex'  => '(?:Apple-)?iPhone7[C,]2',
          'model'  => 'iPhone 6',
          'device' => 'smartphone'
        }
      end

      it 'should return the model name' do
        expect(extractor.call).to eq(device_name)
      end
    
    end

  end

end
