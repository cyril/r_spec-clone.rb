# frozen_string_literal: true

require "expresenter"

module RSpec
  module Error
    # Exception for pending expectations.
    #
    # @api private
    class PendingExpectation < ::RuntimeError
      # @param message [String] The not implemented expectation description.
      #
      # @return [nil] Write a pending expectation to STDOUT.
      def self.result(message)
        ::Expresenter.call(true).with(
          actual:   new(message),
          error:    nil,
          expected: self,
          got:      false,
          matcher:  :raise_exception,
          negate:   true,
          level:    :SHOULD,
          valid:    false
        )
      end
    end
  end
end
