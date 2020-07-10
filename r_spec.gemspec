# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name         = 'r_spec'
  spec.version      = File.read('VERSION.semver').chomp
  spec.author       = 'Cyril Kato'
  spec.email        = 'contact@cyril.email'
  spec.summary      = 'RSpec clone with Fix.'
  spec.description  = 'A small RSpec clone based on Fix specing framework.'
  spec.homepage     = 'https://r-spec.dev/'
  spec.license      = 'MIT'
  spec.files        = Dir['LICENSE.md', 'README.md', 'lib/**/*']

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/cyril/r_spec/issues',
    'documentation_uri' => 'https://rubydoc.info/gems/r_spec/index',
    'source_code_uri' => 'https://github.com/cyril/r_spec'
  }

  spec.add_dependency 'fix', '~> 1.0.0.beta4'
  spec.add_dependency 'fix-expect', '~> 0.4.0'
  spec.add_dependency 'matchi-rspec', '~> 1.0.0'

  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-thread_safety'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'spectus', '~> 3.1'
  spec.add_development_dependency 'yard'
end
