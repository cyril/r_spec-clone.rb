# frozen_string_literal: true

require "expresenter"

module RSpec
  # Namespace for the requirement.
  #
  # @api private
  class Requirement
    def self.pending(description)
      ::Expresenter.call(true).new(
        actual:   nil,
        error:    Pending.new(description),
        expected: nil,
        got:      nil,
        matcher:  :eql,
        negate:   false,
        level:    :MAY,
        valid:    false
      )
    end

    # Initialize the requirement class.
    #
    # @param actual   [#object_id]  The actual object to test.
    # @param matcher  [#matches?]   The matcher.
    # @param negate   [Boolean]     Positive or negative assertion?
    def initialize(actual:, matcher:, negate:)
      @exam     = Exam.new(actual: actual, negate: negate, matcher: matcher)
      @matcher  = matcher
      @negate   = negate
      @result   = expectation_result
    end

    # @return [Exam] The exam.
    attr_reader :exam

    # @return [#matches?] The matcher that performed a boolean comparison
    #   between the actual value and the expected value.
    attr_reader :matcher

    # @return [Expresenter::Fail, Expresenter::Pass] The test result.
    attr_reader :result

    # Evaluate the expectation.
    #
    # @return [Boolean] Report if the expectation pass or fail?
    def pass?
      exam.valid?
    end

    # The consequence of the expectation.
    #
    # @return [nil] The test passed.
    # @raise [SystemExit] The test failed.
    def call
      if result.passed?
        puts result.colored_string
      else
        abort result.colored_string
      end
    end

    protected

    # @note The boolean comparison between the actual value and the expected
    #   value can be evaluated to a negative assertion.
    #
    # @return [Boolean] Positive or negative assertion?
    def negate?
      @negate
    end

    # The result of the expectation.
    #
    # @return [Expresenter::Fail, Expresenter::Pass] The test result.
    def expectation_result
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
  end
end

require_relative "exam"
require_relative "pending"
