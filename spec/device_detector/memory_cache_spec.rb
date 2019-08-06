# frozen_string_literal: true

require_relative '../spec_helper'

describe DeviceDetector::MemoryCache do
  let(:subject) { DeviceDetector::MemoryCache.new(config) }

  let(:config) { {} }

  describe '#set' do
    describe 'string key' do
      let(:key) { 'string' }

      it 'sets the value under the key' do
        subject.set(key, 'value')

        subject.data[key].must_equal 'value'
      end

      it 'returns the value' do
        subject.set(key, 'value').must_equal 'value'
        subject.set(key, false).must_equal false
        assert_nil subject.set(key, nil)
      end
    end

    describe 'array key' do
      let(:key) { %w[string1 string2] }

      it 'sets the value under the key' do
        subject.set(key, 'value')

        subject.data[String(key)].must_equal 'value'
      end
    end

    describe 'nil value' do
      let(:key) { 'string' }
      let(:internal_value) { DeviceDetector::MemoryCache::STORES_NIL_VALUE }

      it 'sets the value under the key' do
        subject.set(key, nil)

        subject.data[String(key)].must_equal internal_value
        assert_nil subject.get(key)
      end

      it 'sets the value under the key' do
        subject.get_or_set(key, nil)

        subject.data[String(key)].must_equal internal_value
        assert_nil subject.get(key)
      end
    end

    describe 'false value' do
      let(:key) { 'string' }

      it 'sets the value under the key' do
        subject.set(key, false)

        subject.data[String(key)].must_equal false
        subject.get(key).must_equal false
      end

      it 'sets the value under the key' do
        subject.get_or_set(key, false)

        subject.data[String(key)].must_equal false
        subject.get(key).must_equal false
      end
    end
  end

  describe '#get' do
    describe 'string key' do
      let(:key) { 'string' }

      it 'gets the value for the key' do
        subject.data[key] = 'value'

        subject.get(key).must_equal 'value'
      end
    end

    describe 'array key' do
      let(:key) { %w[string1 string2] }

      it 'gets the value for the key' do
        subject.data[String(key)] = 'value'

        subject.get(key).must_equal 'value'
      end
    end
  end

  describe '#get_or_set' do
    let(:key) { 'string' }

    describe 'value already present' do
      it 'gets the value for the key from cache' do
        subject.data[key] = 'value'

        block_called = false
        value = subject.get_or_set(key) do
          block_called = true
        end

        value.must_equal 'value'
        block_called.must_equal false
      end

      it 'returns the value' do
        subject.data[key] = 'value2'
        subject.get_or_set(key, 'value').must_equal 'value2'
      end
    end

    describe 'value not yet present' do
      it 'evaluates the block and sets the result' do
        block_called = false
        subject.get_or_set(key) do
          block_called = true
        end

        block_called.must_equal true
        subject.data[key].must_equal true
      end

      it 'returns the value' do
        subject.get_or_set(key, 'value').must_equal 'value'
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

      subject.data.keys.size.must_equal 3
    end
  end
end
