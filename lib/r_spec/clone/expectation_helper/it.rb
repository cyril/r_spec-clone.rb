# frozen_string_literal: true

require_relative "matcher"
require_relative File.join("..", "expectation_target")

module RSpec
  module Clone
    module ExpectationHelper
      # The words of an `it` example: `expect`, `is_expected` and the
      # matchers.
      module It
        include Matcher

        # Wraps the target of an expectation: a value, or a block whose
        # value or exception the matcher judges.
        #
        # @example
        #   expect("foo")
        #   expect { 1 / 0 }
        #
        # @param values [Array] the actual value, when no block is given
        # @yieldreturn [Object] the actual value
        # @return [ExpectationTarget]
        # @raise [ArgumentError] with both a value and a block, or neither
        def expect(*values, &block)
          raise ::ArgumentError, "expect takes one value or a block" unless values.size + (block ? 1 : 0) == 1

          ExpectationTarget.new(block || -> { values.fetch(0) })
        end

        # Wraps the subject as a block: `is_expected.to raise_exception X`
        # judges what `subject` raises.
        #
        # @return [ExpectationTarget]
        def is_expected
          expect { subject }
        end
      end
    end
  end
end
