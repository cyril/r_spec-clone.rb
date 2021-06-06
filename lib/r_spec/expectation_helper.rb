# frozen_string_literal: true

require "matchi/rspec"

module RSpec
  # This module defines a number of methods to create expectations, which are
  # automatically included into example namespaces.
  #
  # @api private
  module ExpectationHelper
    # Include a collection of expectation matchers 🤹
    #
    # @see https://github.com/fixrb/matchi
    # @see https://github.com/fixrb/matchi-rspec
    include ::Matchi::Helper

    # Create an expectation for a spec.
    #
    # @param value [#object_id, nil]  An actual value.
    # @param block [#call, nil]       A code to evaluate.
    #
    # @return [Block, Value] The wrapped target of an expectation.
    #
    # @api public
    def expect(value = self.class.superclass, &block)
      ExpectationTarget.call(self.class.superclass, value, block)
    end

    # Wraps the target of an expectation with the subject as actual value.
    #
    # @return (see #expect)
    #
    # @api public
    def is_expected
      expect(subject)
    end

    # Mark a spec as pending, expectation results will be ignored.
    #
    # @param description [String] The reason why the example is pending.
    #
    # @return [nil] Write a message to STDOUT.
    #
    # @api public
    def pending(description)
      Pending.result(description)
    end
  end
end

require_relative "expectation_target"
require_relative "pending"
