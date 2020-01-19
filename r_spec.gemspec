# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'r_spec'
  spec.version       = File.read('VERSION.semver').chomp
  spec.authors       = 'Cyril Kato'
  spec.email         = 'contact@cyril.email'

  spec.summary       = 'RSpec clone with Fix.'
  spec.description   = 'A small RSpec clone based on Fix specing framework.'
  spec.homepage      = 'https://github.com/cyril/r_spec'
  spec.license       = 'MIT'

  spec.files         = Dir['LICENSE.md', 'README.md', 'lib/**/*']

  spec.add_dependency 'fix',                    '~> 1.0.0.beta4'
  spec.add_dependency 'fix-expect',             '~> 0.4.0'
  spec.add_dependency 'matchi-rspec',           '~> 1.0.0'

  spec.add_development_dependency 'bundler',    '~> 2.1'
  spec.add_development_dependency 'rake',       '~> 13.0'
  spec.add_development_dependency 'rubocop',    '~> 0.79'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'simplecov',  '~> 0.17'
  spec.add_development_dependency 'spectus',    '~> 3.1'
  spec.add_development_dependency 'yard',       '~> 0.9'
end
