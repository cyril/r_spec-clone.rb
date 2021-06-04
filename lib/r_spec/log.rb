# frozen_string_literal: true

require "expresenter"

module RSpec
  # Exception for debugging purpose.
  class Log < ::NoMethodError
    # @param message [String] A message to log to the console.
    #
    # @return [nil] Write a log message to STDOUT.
    def self.result(message)
      puts "  " + ::Expresenter.call(true).with(
        actual:   nil,
        error:    new(message),
        expected: 42,
        got:      nil,
        matcher:  :be,
        negate:   false,
        level:    :MAY,
        valid:    false
      ).colored_string
    end
  end
end
