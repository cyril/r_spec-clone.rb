# frozen_string_literal: true

require "expresenter"

module RSpec
  # Exception for pending expectations.
  #
  # @api private
  class Pending < ::NotImplementedError
    # @param message [String] The not implemented expectation description.
    #
    # @return [nil] Write a pending expectation to STDOUT.
    def self.result(message)
      warn "  " + ::Expresenter.call(true).with(
        actual:   new(message),
        error:    nil,
        expected: self,
        got:      false,
        matcher:  :raise_exception,
        negate:   true,
        level:    :SHOULD,
        valid:    false
      ).colored_string
    end
  end
end
