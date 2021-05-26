# frozen_string_literal: true

require "expresenter"

module RSpec
  class Requirement
    # Initialize the requirement class.
    #
    # @param actual   [#object_id]  The actual object to test.
    # @param matcher  [#matches?]   The matcher.
    # @param negate   [Boolean]     Positive or negative assertion?
    def initialize(actual:, matcher:, negate:)
      @exam     = Exam.new(actual: actual, negate: negate, matcher: matcher)
      @matcher  = matcher
      @negate   = negate
    end

    # @return [Exam] The exam.
    attr_reader :exam

    # @return [#matches?] The matcher that performed a boolean comparison
    #   between the actual value and the expected value.
    attr_reader :matcher

    # Evaluate the expectation.
    #
    # @return [Boolean] Report if the expectation pass or fail?
    def pass?
      exam.valid?
    end

    # The result of the expectation.
    #
    # @return [Expresenter::Fail, Expresenter::Pass] The test result.
    def call
      ::Expresenter.call(pass?).new(
        actual:   exam.actual,
        error:    nil,
        expected: matcher.expected,
        got:      exam.got,
        negate:   negate?,
        valid:    exam.valid?,
        matcher:  matcher.class.to_sym,
        level:    :MUST
      )
    end

    protected

    # @note The boolean comparison between the actual value and the expected
    #   value can be evaluated to a negative assertion.
    #
    # @return [Boolean] Positive or negative assertion?
    def negate?
      @negate
    end
  end
end
