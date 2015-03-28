# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'd2e/version'

Gem::Specification.new do |spec|
  spec.name          = "d2e"
  spec.version       = D2e::VERSION
  spec.authors       = ["tily"]
  spec.email         = ["tily05@gmail.com"]
  spec.summary       = %q{diff to events}
  spec.description   = %q{diff to events}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
