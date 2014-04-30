# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'porteiro/version'

Gem::Specification.new do |spec|
  spec.name          = "porteiro"
  spec.version       = Porteiro::VERSION
  spec.authors       = ["bradwheel"]
  spec.email         = ["bradley.m.wheel@gmail.com"]
  spec.description   = %q{Authorization for controllers modeled after Pundit.}
  spec.summary       = %q{Authorization for controllers modeled after Pundit.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.0.0"
  spec.add_development_dependency "activerecord", ">= 3.0.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
