# frozen_string_literal: true

require_relative "shared"
require_relative File.join("..", "expectation_target", "block")

module RSpec
  module Clone
    module ExpectationHelper
      # {RSpec::Clone::Dsl.its}'s expectation helper module.
      module Its
        include Shared

        # Wraps the target of an expectation with the actual value.
        #
        # @return [Block] The wrapped target of an expectation.
        #
        # @example
        #   is_expected # => #<RSpec::Clone::ExpectationTarget::Block:0x00007f @callable=#<Proc:0x00007f>>
        #
        # @api public
        def is_expected
          ExpectationTarget::Block.new(method(:actual))
        end
      end
    end
  end
end
