# frozen_string_literal: true

require "fileutils"
require "simplecov"

SimpleCov.start do
  skip "/spec/"
  enable_coverage :branch
  # Each context runs in a child process: merge the share of every child.
  merge_subprocesses true
  # The whole suite covers everything; one file, run on its own, does not.
  minimum_coverage(line: 100, branch: 100) if File.basename($PROGRAM_NAME) == "rake_test_loader.rb"
end

# Start from an empty resultset: SimpleCov merges the results of the last
# ten minutes, and a previous run would cover for this one.
FileUtils.rm_f(File.join(SimpleCov.coverage_path, ".resultset.json"))

# A child the code under test forks leaves the clone through exit!, which
# runs no at_exit handler, where SimpleCov stores its share: store it just
# before. The original is called directly, not through super, so that a
# block redefining exit! does not change it.
exit_bang = Process.method(:exit!)
Process.singleton_class.prepend(
  Module.new do
    define_method(:exit!) do |status = false|
      SimpleCov.result
    ensure
      exit_bang.call(status)
    end
  end
)

require_relative File.join("..", "lib", "r_spec", "clone")
