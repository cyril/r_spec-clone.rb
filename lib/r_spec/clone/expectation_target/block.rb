# frozen_string_literal: true

require_relative "base"

module RSpec
  module Clone
    module ExpectationTarget
      # Wraps the target of an expectation with a block.
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
      # @note `RSpec::Clone::ExpectationTarget::Block` is not intended to be
      #   instantiated directly by users. Use `expect` instead.
      class Block < Base
        protected

        # @param matcher  [#matches?] The matcher.
        # @param negate   [Boolean]   The assertion is positive or negative.
        #
        # @return (see Base#absolute_requirement)
        #
        # @raise (see Base#absolute_requirement)
        def absolute_requirement(matcher:, negate:)
          super(
            ::TestTube.invoke(matcher:, negate:, &@input),
            matcher:,
            negate:
          )
        end
      end
    end
  end
end
