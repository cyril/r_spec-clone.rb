# frozen_string_literal: true

module RSpec
  class Binary
    # Simple file runner for r_spec binary
    # using `load`
    #
    # @note `RSpec::Binary::FileRunnerBasic` is not intended to be instantiated
    #   directly by users. Use `expect` instead.
    class FileRunnerBasic
      class InvalidSpecFile < StandardError; end
      attr_reader :file_path

      def initialize(file_path)
        @file_path = file_path
      end

      def run!
        raise InvalidSpecFile, "#{file_path} is not a file" unless File.file?(file_path)

        load file_path
      end
    end
  end
end
