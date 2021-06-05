# frozen_string_literal: true

require_relative "base"

module RSpec
  module ExpectationTarget
    # Wraps the target of an expectation.
    #
    # @example
    #   expect(something) # => ExpectationTarget::Value wrapping something
    #
    #   # used with `to`
    #   expect(actual).to be(42)
    #
    #   # with `not_to`
    #   expect(actual).not_to be(4)
    #
    # @note `RSpec::ExpectationTarget::Value` is not intended to be instantiated
    #   directly by users. Use `expect` instead.
    #
    # @private
    class Value < Base
      # Instantiate a new expectation target.
      #
      # @param actual [#object_id] The actual value.
      #
      # @api private
      def initialize(actual)
        super()

        @actual = actual
      end

      protected

      # @param matcher  [#matches?] The matcher.
      # @param negate   [Boolean]   Positive or negative assertion?
      #
      # @raise (see Base#result)
      # @return (see Base#result)
      def absolute_requirement(matcher:, negate:)
        valid = negate ^ matcher.matches? { @actual }

        result(
          actual:  @actual,
          error:   nil,
          got:     valid,
          matcher: matcher,
          negate:  negate,
          valid:   valid
        )
      end
    end
  end
end
