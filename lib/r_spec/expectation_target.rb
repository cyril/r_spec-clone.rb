# frozen_string_literal: true

require "expresenter"

module RSpec
  # Wraps the target of an expectation.
  #
  # @example
  #   expect(something) # => ExpectationTarget wrapping something
  #
  #   # used with `to`
  #   expect(actual).to be(42)
  #
  #   # with `not_to`
  #   expect(actual).not_to be(4)
  #
  # @note `ExpectationTarget` is not intended to be instantiated directly by
  #   users. Use `expect` instead.
  class ExpectationTarget
    # Instantiate a new expectation target.
    #
    # @param actual [#object_id] The actual value.
    #
    # @api private
    def initialize(actual)
      @actual = actual
    end

    # Runs the given expectation, passing if `matcher` returns true.
    #
    # @example _Absolute requirement_ definition
    #   expect("foo".upcase).to eq("foo")
    #
    # @param matcher [#matches?] The matcher.
    #
    # @raise (see #result)
    # @return (see #result)
    def to(matcher)
      absolute_requirement(matcher: matcher, negate: false)
    end

    # Runs the given expectation, passing if `matcher` returns false.
    #
    # @example _Absolute prohibition_ definition
    #   expect("foo".size).not_to be(4)
    #
    # @param (see #to)
    #
    # @raise (see #result)
    # @return (see #result)
    def not_to(matcher)
      absolute_requirement(matcher: matcher, negate: true)
    end

    protected

    # @param matcher  [#matches?] The matcher.
    # @param negate   [Boolean]   Positive or negative assertion?
    #
    # @raise (see #result)
    # @return (see #result)
    def absolute_requirement(matcher:, negate:)
      result(
        matcher: matcher,
        negate:  negate,
        passed:  negate ^ matcher.matches? { @actual }
      )
    end

    # @param matcher  [#matches?] The matcher.
    # @param negate   [Boolean]   Positive or negative assertion?
    # @param passed   [Boolean]   The result of an expectation.
    #
    # @return [nil] Write a message to STDOUT.
    #
    # @raise [SystemExit] Terminate execution immediately by calling
    #   `Kernel.exit(false)` with a failure message written to STDERR.
    def result(matcher:, negate:, passed:)
      puts "  " + ::Expresenter.call(passed).with(
        actual:   @actual,
        error:    nil,
        expected: matcher.expected,
        got:      passed,
        negate:   negate,
        valid:    passed,
        matcher:  matcher.class.to_sym,
        level:    :MUST
      ).colored_string
    rescue ::Expresenter::Fail => e
      abort "  #{e.colored_string}"
    end
  end
end
