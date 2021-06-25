# frozen_string_literal: true

module RSpec
  class Binary
    # Simple file runner for r_spec binary
    # using `load`
    #
    # @note `RSpec::Binary::TargetFiles` is not intended to be instantiated
    #   directly by users. Use `expect` instead.
    class TargetFiles
      def initialize(input_files)
        @input_files = input_files
      end

      def running_files
        if @input_files.empty?
          Dir.glob("spec/**/*_spec.rb").select { |e| File.file? e }
        else
          @input_files
        end
      end
    end
  end
end
