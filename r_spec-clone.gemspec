# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name                   = "r_spec-clone"
  spec.version                = File.read(File.join(__dir__, "VERSION.semver")).chomp
  spec.author                 = "Cyril Kato"
  spec.email                  = "contact@cyril.email"
  spec.summary                = "A minimalist RSpec clone"
  spec.description            = "The essentials of RSpec, with fewer surprises: no monkey patch, no at_exit hook, " \
                                "no memoization, a child process per context, and the expected value always on the " \
                                "receiving end of a comparison. Built on the testing libraries of Fixrb."
  spec.homepage               = "https://github.com/cyril/r_spec-clone.rb"
  spec.license                = "MIT"
  spec.files                  = Dir["LICENSE.md", "README.md", "lib/**/*.rb", base: __dir__]
  spec.required_ruby_version  = ">= 3.3.0"

  spec.metadata["bug_tracker_uri"]       = "https://github.com/cyril/r_spec-clone.rb/issues"
  spec.metadata["changelog_uri"]         = "https://github.com/cyril/r_spec-clone.rb#changes-in-20"
  spec.metadata["documentation_uri"]     = "https://rubydoc.info/gems/r_spec-clone"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["source_code_uri"]       = "https://github.com/cyril/r_spec-clone.rb"

  spec.add_dependency "defi",    "~> 4.0"
  spec.add_dependency "matchi",  "~> 6.0"
  spec.add_dependency "spectus", "~> 6.0"
end
