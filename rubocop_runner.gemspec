# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop_runner/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop_runner'
  spec.version       = RubocopRunner::VERSION
  spec.authors       = ['Andreas Eger']
  spec.email         = ['andreas.eger@runtastic.com']
  spec.summary       = 'runs rubocop for all changed files'
  spec.description   = <<-DESC
  This gem provides means of running rubocop including auto-correct on all
  files which are currently staged in git. This can be easily used as pre-commit
  hook with the included template.
  DESC
  spec.homepage      = 'https://github.com/runtastic/rubocop_runner'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
end
