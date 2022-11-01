# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'FillParams/version'

Gem::Specification.new do |spec|
  spec.name          = 'fillparams'
  spec.version       = FillParams::VERSION
  spec.authors       = ['Krzysztof Hasiński', 'Justyna Wojtczak']
  spec.email         = ['krzysztof.hasinski+fillparams@gmail.com', 'justine84+fillparams@gmail.com']
  spec.summary       = 'Parameters handler, for usage see github page'
  spec.description   = 'A gem for filling in parameters automatically'
  spec.homepage      = 'http://github.com/khasinski/fillparams'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
