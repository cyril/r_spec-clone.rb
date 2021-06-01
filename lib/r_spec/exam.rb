# frozen_string_literal: true

module RSpec
  # Exam class.
  #
  # @api private
  class Exam
    # Execute the untested code from the given value against the matcher.
    #
    # @param actual     [#object_id]  The actual object to test.
    # @param negate     [Boolean]     Positive or negative assertion?
    # @param matcher    [#matches?]   The matcher.
    def initialize(actual:, negate:, matcher:)
      @actual = actual
      @got    = negate ^ matcher.matches? { actual }
    end
    # @return [#object_id] The actual value.
    attr_reader :actual

    # @return [Boolean] Report to the spec requirement level if the
    #   expectation is true or false.
    attr_reader :got

    # Report to the spec requirement if the test pass or fail.
    #
    # @return [Boolean] Report if the test pass or fail?
    def valid?
      got
    end
  end
end
