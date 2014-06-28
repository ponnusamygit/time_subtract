# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_subtract/version'

Gem::Specification.new do |spec|
  spec.name          = "time_subtract"
  spec.version       = TimeSubtract::VERSION
  spec.authors       = ["Ponnusamy"]
  spec.email         = ["ponnusamy.gac@gmail.com"]
  spec.summary       = %q{Subtract two time and get a smart string as a return value}
  spec.description   = %q{Time object subtraction method available for easy use}
  spec.homepage      = "https://github.com/ponnusamygit/time_subtract"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency "activesupport"

end
