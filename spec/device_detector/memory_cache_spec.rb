require 'spec_helper'

RSpec.describe DeviceDetector::MemoryCache do

  let(:subject) { DeviceDetector::MemoryCache.new(config) }

  let(:config) { {} }

  describe '#set' do

    context 'string key' do

      let(:key) { 'string' }

      it 'sets the value under the key' do
        subject.set(key, 'value')

        expect(subject.data[key]).to eq('value')
      end

    end

    context 'array key' do

      let(:key) { ['string1', 'string2'] }

      it 'sets the value under the key' do
        subject.set(key, 'value')

        expect(subject.data[String(key)]).to eq('value')
      end

    end

  end

  describe '#get' do

    context 'string key' do

      let(:key) { 'string' }

      it 'gets the value for the key' do
        subject.data[key] = 'value'

        expect(subject.get(key)).to eq('value')
      end

    end

    context 'array key' do

      let(:key) { ['string1', 'string2'] }

      it 'gets the value for the key' do
        subject.data[String(key)] = 'value'

        expect(subject.get(key)).to eq('value')
      end

    end

  end

  describe '#get_or_set' do

    let(:key) { 'string' }

    context 'value already present' do

      it 'gets the value for the key from cache' do
        subject.data[key] = 'value'

        block_called = false
        value = subject.get_or_set(key) do
          block_called = true
        end

        expect(value).to eq('value')
        expect(block_called).to eq(false)
      end

    end

    context 'value not yet present' do

      it 'evaluates the block and sets the result' do
        block_called = false
        subject.get_or_set(key) do
          block_called = true
        end

        expect(block_called).to eq(true)
        expect(subject.data[key]).to eq(true)
      end

    end

  end

  describe 'cache purging' do

    let(:config) { { max_cache_keys: 3 } }

    it 'purges the cache when key size arrives at max' do
      subject.set('1', 'foo')
      subject.set('2', 'bar')
      subject.set('3', 'baz')
      subject.set('4', 'boz')

      expect(subject.data.keys.size).to eq(3)
    end

  end

end
