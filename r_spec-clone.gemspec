# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name         = "r_spec-clone"
  spec.version      = File.read("VERSION.semver").chomp
  spec.author       = "Cyril Kato"
  spec.email        = "contact@cyril.email"
  spec.summary      = "A minimalist RSpec clone"
  spec.description  = "#{spec.summary} with all the essentials."
  spec.homepage     = "https://r-spec.dev/"
  spec.license      = "MIT"
  spec.files        = Dir["LICENSE.md", "README.md", "lib/**/*"]

  spec.required_ruby_version = ">= 2.7.6"

  spec.metadata = {
    "bug_tracker_uri"       => "https://github.com/cyril/r_spec-clone.rb/issues",
    "documentation_uri"     => "https://rubydoc.info/gems/r_spec-clone",
    "source_code_uri"       => "https://github.com/cyril/r_spec-clone.rb",
    "wiki_uri"              => "https://github.com/cyril/r_spec-clone.rb/wiki",
    "rubygems_mfa_required" => "true"
  }

  spec.add_dependency "aw", "~> 0.2.0"
  spec.add_dependency "expresenter", "~> 1.4.0"
  spec.add_dependency "matchi", "~> 3.3.1"
  spec.add_dependency "test_tube", "~> 2.1.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop-md"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "rubocop-thread_safety"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"
end
