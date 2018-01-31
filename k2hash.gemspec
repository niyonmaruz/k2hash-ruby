# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "k2hash/version"

Gem::Specification.new do |spec|
  spec.name          = "k2hash"
  spec.version       = K2hash::VERSION
  spec.authors       = ["Hidenori Suzuki"]
  spec.email         = ["hidenori.suzuki@yahoo.com"]

  spec.summary       = %q{k2hash ruby binding}
  spec.description   = %q{k2hash ruby binding}
  spec.homepage      = "https://github.com/niyonmaruz/k2hash-ruby"
  spec.license       = "MIT"
  spec.extensions    = %w[ext/k2hash/extconf.rb]

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
    #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  #spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #  f.match(%r{^(test|spec|features)/})
  #end
  #spec.bindir        = "exe"
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  #spec.require_paths = ["ext", "lib"]

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["ext", "lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
