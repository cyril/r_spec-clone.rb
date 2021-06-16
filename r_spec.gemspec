# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name         = "r_spec"
  spec.version      = File.read("VERSION.semver").chomp
  spec.author       = "Cyril Kato"
  spec.email        = "contact@cyril.email"
  spec.summary      = "A minimalist RSpec clone"
  spec.description  = "#{spec.summary} with all the essentials."
  spec.homepage     = "https://r-spec.dev/"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")
  spec.license      = "MIT"
  spec.files        = Dir["LICENSE.md", "README.md", "lib/**/*"]

  spec.metadata = {
    "bug_tracker_uri"   => "https://github.com/cyril/r_spec.rb/issues",
    "documentation_uri" => "https://rubydoc.info/gems/r_spec",
    "source_code_uri"   => "https://github.com/cyril/r_spec.rb",
    "wiki_uri"          => "https://github.com/cyril/r_spec.rb/wiki"
  }

  spec.add_dependency "expresenter", "~> 1.2.1"
  spec.add_dependency "matchi-rspec", "~> 1.1.2"
  spec.add_dependency "spectus", "~> 3.3.4"

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
