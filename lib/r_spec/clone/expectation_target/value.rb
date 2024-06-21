# frozen_string_literal: true

require_relative "base"

module RSpec
  module Clone
    module ExpectationTarget
      # Wraps the target of an expectation with a value.
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
      # @note `RSpec::Clone::ExpectationTarget::Value` is not intended to be
      #   instantiated directly by users. Use `expect` instead.
      class Value < Base
        protected

        # @param matcher  [#matches?] The matcher.
        # @param negate   [Boolean]   The assertion is positive or negative.
        #
        # @return (see Base#absolute_requirement)
        #
        # @raise (see Base#absolute_requirement)
        def absolute_requirement(matcher:, negate:)
          super(
            ::TestTube.pass(@input, matcher:, negate:),
            matcher:,
            negate:
          )
        end
      end
    end
  end
end
