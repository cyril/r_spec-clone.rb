# frozen_string_literal: true

require "expresenter"
require "spectus/exam"

require_relative "base"

module RSpec
  module ExpectationTarget
    # Wraps the target of an expectation.
    #
    # @example
    #   expect { something } # => ExpectationTarget::Block wrapping something
    #
    #   # used with `to`
    #   expect { actual }.to be(42)
    #
    #   # with `not_to`
    #   expect { actual }.not_to be(4)
    #
    # @note `RSpec::ExpectationTarget::Block` is not intended to be instantiated
    #   directly by users. Use `expect` instead.
    #
    # @private
    class Block < Base
      # Instantiate a new expectation target.
      #
      # @param block [#call] The code to evaluate.
      #
      # @api private
      def initialize(block)
        super()

        @callable = block
      end

      protected

      # @param matcher  [#matches?] The matcher.
      # @param negate   [Boolean]   Positive or negative assertion?
      #
      # @raise (see Base#result)
      # @return (see Base#result)
      def absolute_requirement(matcher:, negate:)
        exam = ::Spectus::Exam.new(
          callable:  @callable,
          isolation: false,
          negate:    negate,
          matcher:   matcher
        )

        result(
          actual:  exam.actual,
          error:   exam.exception,
          got:     exam.got,
          matcher: matcher,
          negate:  negate,
          valid:   exam.valid?
        )
      end
    end
  end
end
