# frozen_string_literal: true

require_relative File.join("expectation_target", "block")
require_relative File.join("expectation_target", "value")

module RSpec
  # Wraps the target of an expectation.
  #
  # @api private
  module ExpectationTarget
    # @param undefined_value A sentinel value to be able to tell when the user
    #   did not pass an argument. We can't use `nil` for that because `nil` is a
    #   valid value to pass.
    # @param value [#object_id, nil] An actual value.
    # @param block [#call, nil] A code to evaluate.
    #
    # @return [Block, Value] The wrapped target of an expectation.
    def self.call(undefined_value, value, block)
      if undefined_value.equal?(value)
        raise ::ArgumentError, "Pass either an argument or a block" unless block

        Block.new(block)
      else
        raise ::ArgumentError, "Can't pass both an argument and a block" if block

        Value.new(value)
      end
    end
  end
end
