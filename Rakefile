# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "yard"

Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
  t.warning = true
end

YARD::Rake::YardocTask.new

Dir["tasks/**/*.rake"].each { |t| load t }

task default: %i[
  test
  yard
]
