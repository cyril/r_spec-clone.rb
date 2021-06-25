# frozen_string_literal: true

require_relative "target_files"
require_relative "file_runner_basic"

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

    # catch flaky specs by shuffling the file list
    def run!
      target_files.shuffle.each do |target_file|
        FileRunnerBasic.new(target_file).run!
      end
    end
  end
end
