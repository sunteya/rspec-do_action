# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec-do_action/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-do_action"
  spec.version       = Rspec::DoAction::VERSION
  spec.authors       = ["sunteya"]
  spec.email         = ["sunteya@gmail.com"]
  spec.summary       = %q{add 'acton' and some useful methods for rspec one-liner syntax.}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.3.2"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "codeclimate-test-reporter"
end
