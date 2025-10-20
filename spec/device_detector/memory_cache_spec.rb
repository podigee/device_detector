# frozen_string_literal: true

describe DeviceDetector::MemoryCache do
  subject { described_class.new(config) }

  let(:config) { {} }

  describe '#set' do
    describe 'string key' do
      let(:key) { 'string' }

      it 'sets the value under the key' do
        subject.set(key, 'value')

        expect(subject.data[key]).to eq 'value'
      end

      it 'returns the value' do
        expect(subject.set(key, 'value')).to eq 'value'
        expect(subject.set(key, false)).to eq false
        expect(subject.set(key, nil)).to be_nil
      end
    end

    describe 'array key' do
      let(:key) { %w[string1 string2] }

      it 'sets the value under the key' do
        subject.set(key, 'value')

        expect(subject.data[String(key)]).to eq 'value'
      end
    end

    describe 'nil value' do
      let(:key) { 'string' }
      let(:internal_value) { DeviceDetector::MemoryCache::STORES_NIL_VALUE }

      it 'sets the value under the key' do
        subject.set(key, nil)

        expect(subject.data[String(key)]).to eq internal_value
        expect(subject.get(key)).to be_nil
      end

      it 'sets the value under the key' do
        subject.get_or_set(key, nil)

        expect(subject.data[String(key)]).to eq internal_value
        expect(subject.get(key)).to be_nil
      end
    end

    describe 'false value' do
      let(:key) { 'string' }

      it 'sets the value under the key' do
        subject.set(key, false)

        expect(subject.data[String(key)]).to eq false
        expect(subject.get(key)).to eq false
      end

      it 'sets the value under the key' do
        subject.get_or_set(key, false)

        expect(subject.data[String(key)]).to eq false
        expect(subject.get(key)).to eq false
      end
    end
  end

  describe '#get' do
    describe 'string key' do
      let(:key) { 'string' }

      it 'gets the value for the key' do
        subject.data[key] = 'value'

        expect(subject.get(key)).to eq 'value'
      end
    end

    describe 'array key' do
      let(:key) { %w[string1 string2] }

      it 'gets the value for the key' do
        subject.data[String(key)] = 'value'

        expect(subject.get(key)).to eq 'value'
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

        expect(value).to eq 'value'
        expect(block_called).to eq false
      end

      it 'returns the value' do
        subject.data[key] = 'value2'
        expect(subject.get_or_set(key, 'value')).to eq 'value2'
      end
    end

    describe 'value not yet present' do
      it 'evaluates the block and sets the result' do
        block_called = false
        subject.get_or_set(key) do
          block_called = true
        end

        expect(block_called).to eq true
        expect(subject.data[key]).to eq true
      end

      it 'returns the value' do
        expect(subject.get_or_set(key, 'value')).to eq 'value'
      end
    end
  end

  describe 'cache partial purging' do
    let(:config) { { max_cache_keys: 3 } }

    it 'purges the cache when key size arrives at max' do
      subject.set('1', 'foo')
      subject.set('2', 'bar')
      subject.set('3', 'baz')
      subject.set('4', 'boz')

      expect(subject.data.keys.size).to eq 3
    end
  end

  describe '.purge!' do
    before { subject.set('some_key', 'value') }

    it 'removes all cached keys' do
      expect { subject.purge! }.to change(subject, :data).from({ 'some_key' => 'value' }).to({})
    end
  end
end
