require 'active_support'
require 'active_support/core_ext/hash'
require 'active_support/hash_with_indifferent_access'

require 'cachable/version'
require 'cachable/key'

module Cachable
  extend ActiveSupport::Concern

  module ClassMethods
    def find(*attributes)

      cache_key = Key.new(self, attributes)

      Rails.cache.delete(cache_key) if Rails.cache.fetch(cache_key) == []

      Rails.cache.fetch(cache_key) { super(*attributes) }
    end
  end
end
