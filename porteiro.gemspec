# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'porteiro/version'

Gem::Specification.new do |spec|
  spec.name          = "porteiro"
  spec.version       = Porteiro::VERSION
  spec.authors       = ["bradwheel"]
  spec.email         = ["bradley.m.wheel@gmail.com"]
  spec.summary       = %q{blah blah}
  spec.description   = %q{blah blah}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "pry"
end
