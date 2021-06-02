# frozen_string_literal: true

require "expresenter"

module RSpec
  # Namespace for the requirement.
  class AbsoluteRequirement
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
    # @param actual   [#object_id]  The actual value.
    # @param matcher  [#matches?]   The matcher.
    # @param negate   [Boolean]     Positive or negative assertion?
    def initialize(actual:, matcher:, negate:)
      @actual   = actual
      @got      = negate ^ matcher.matches? { actual }
      @matcher  = matcher
      @negate   = negate
      @result   = expectation_result
    end

    # @return [#object_id] The actual value.
    attr_reader :actual

    # @return [Boolean] Report to the spec requirement level if the
    #   expectation is true or false.
    attr_reader :got

    # @return [#matches?] The matcher that performed a boolean comparison
    #   between the actual value and the expected value.
    attr_reader :matcher

    # @return [Expresenter::Fail, Expresenter::Pass] The test result.
    attr_reader :result

    # Evaluate the expectation.
    #
    # @return [Boolean] Report if the expectation pass or fail?
    def pass?
      valid?
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
        actual:   actual,
        error:    nil,
        expected: matcher.expected,
        got:      got,
        negate:   negate?,
        valid:    valid?,
        matcher:  matcher.class.to_sym,
        level:    :MUST
      )
    end

    # Report to the spec requirement if the test pass or fail.
    #
    # @return [Boolean] Report if the test pass or fail?
    def valid?
      got
    end
  end
end

require_relative "pending"
