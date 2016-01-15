require 'spec_helper'

describe Cachable::Key do
  let (:key) { Cachable::Key.new(Class, [:all, params: { a: 1, b: 2 }]) }

  it 'has a class' do
    expect(key).to respond_to(:klass)
  end

  it 'has a query' do
    expect(key).to respond_to(:query)
  end

  it 'has options' do
    expect(key).to respond_to(:options)
  end

  describe '#cache_key' do
    it 'has a cache_key' do
      expect(key).to respond_to(:cache_key)
    end

    it 'responds to #to_param' do
      expect(key.cache_key).to respond_to(:to_param)
    end

    it 'recognises the same attributes in a different order' do
      other_key = Cachable::Key.new(Class, [:all, params: { b: 2, a: 1 }])
      expect(key.cache_key).to eq(other_key.cache_key)
    end

    it 'recognises different attribute values are not the same' do
      other_key = Cachable::Key.new(Class, [:all, params: { a: 2, b: 2 }])
      expect(key.cache_key).to_not eq(other_key.cache_key)
    end

    it 'recognises hash and string hash values as being the same' do
      other_key = Cachable::Key.new(Class, [:all, params: { 'a' => 1, 'b' => 2 }])
      expect(key.cache_key).to eq(other_key.cache_key)
    end

    it 'recognises different classes with the same attributes are not the same' do
      other_key = Cachable::Key.new(Module, [key.query, key.options])
      expect(key.cache_key).to_not eq(other_key.cache_key)
    end

    it 'works with no attributes' do
      expect do
        Cachable::Key.new(Class)
      end.to_not raise_error
    end

    # production workers should share cache
    it 'has the same value across processes' do
      read, write = IO.pipe
      Process.fork { write.print key.cache_key }
      write.close
      other_thread_key = read.read
      read.close
      expect(key.cache_key).to eq(other_thread_key)
    end
  end
end
