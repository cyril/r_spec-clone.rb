# frozen_string_literal: true

require_relative File.join("target_files")
require_relative File.join("file_runner_basic")

module RSpec
  # Spec file executor
  #
  # @note `RSpec::Binary` is not intended to be instantiated
  #   directly by users. Use `expect` instead.
  class Binary
    attr_reader :target_files

    def initialize(argv:)
      @target_files = TargetFiles.new(argv).running_files
    end

    def run!
      target_files.each do |target_file|
        FileRunnerBasic.new(target_file).run!
      end
    end
  end
end
