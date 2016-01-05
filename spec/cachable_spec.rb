require 'spec_helper'

describe Cachable do
  it 'has a version number' do
    expect(Cachable::VERSION).not_to be nil
  end
end
