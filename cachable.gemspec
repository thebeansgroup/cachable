# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cachable/version'

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = "cachable"
  spec.version       = Cachable::VERSION
  spec.authors       = ["Tom Grimley, Vincent Siebert"]
  spec.email         = ["tom.grimley@thebeansgroup.com", "vincent@thebeansgroup.com"]

  spec.summary       = %q{Caching mixin for active resource et al}
  spec.description   = %q{Caching mixin for active resource et al}
  spec.homepage      = "https://github.com/thebeansgroup/cachable"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "railties", "~> 4.2.0"
end
