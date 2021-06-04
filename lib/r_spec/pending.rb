# frozen_string_literal: true

require "expresenter"

module RSpec
  # Exception for pending expectations.
  class Pending < ::NotImplementedError
    # @param description [String] The not implemented expectation description.
    #
    # @return [nil] Write a pending expectation to STDOUT.
    def self.result(description)
      puts ::Expresenter.call(true).with(
        actual:   nil,
        error:    new(description),
        expected: nil,
        got:      nil,
        matcher:  :eql,
        negate:   false,
        level:    :MAY,
        valid:    false
      ).colored_string
    end
  end
end
