# frozen_string_literal: true

module RSpec
  # Wraps the target of an expectation.
  module ExpectationTarget
    def self.call(empty, value, block)
      if empty.equal?(value)
        raise ::ArgumentError, "Pass either an argument or a block" unless block

        Block.new(block)
      else
        raise ::ArgumentError, "Cannot pass both an argument and a block" if block

        Value.new(value)
      end
    end
  end
end

require_relative File.join("expectation_target", "block")
require_relative File.join("expectation_target", "value")
