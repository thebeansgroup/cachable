module Cachable
  class Key

    attr_reader :klass, :query, :options

    def initialize(klass, attributes = [])
      @klass = klass
      @query, @options = attributes

      standardize_options
    end

    def cache_key
      Digest::SHA256.hexdigest("#{@klass}-#{@query}-#{@options}")
    end

    private
    def standardize_options

      @options = ActiveSupport::HashWithIndifferentAccess.new(
        @options).deep_symbolize_keys

        @options[:params] = @options[:params].try(:sort).to_h

    end
  end
end
