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

      cached_data = Rails.cache.fetch(cache_key)
      if cached_data.is_a?(ActiveResource::Collection) && cached_data.elements.empty?
        Rails.cache.delete(cache_key)
      end

      Rails.cache.fetch(cache_key) { super(*attributes) }
    end
  end
end
