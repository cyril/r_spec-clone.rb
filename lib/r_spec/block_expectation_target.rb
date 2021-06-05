# frozen_string_literal: true

require "expresenter"
require "spectus/exam"

module RSpec
  # Wraps the target of an expectation.
  #
  # @example
  #   expect { something } # => BlockExpectationTarget wrapping something
  #
  #   # used with `to`
  #   expect { actual }.to be(42)
  #
  #   # with `not_to`
  #   expect { actual }.not_to be(4)
  #
  # @note `BlockExpectationTarget` is not intended to be instantiated directly
  #   by users. Use `expect` instead.
  class BlockExpectationTarget
    # Instantiate a new expectation target.
    #
    # @param block [#Proc] The code to evaluate.
    #
    # @api private
    def initialize(&block)
      @callable = block
    end

    # Runs the given expectation, passing if `matcher` returns true.
    #
    # @example _Absolute requirement_ definition
    #   expect { "foo".upcase }.to eq("foo")
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
    #   expect { "foo".size }.not_to be(4)
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
      exam = ::Spectus::Exam.new(
        callable:  @callable,
        isolation: false,
        negate:    negate,
        matcher:   matcher
      )

      result(
        actual:  exam.actual,
        error:   exam.exception,
        got:     exam.got,
        matcher: matcher,
        negate:  negate,
        valid:   exam.valid?
      )
    end

    # @param actual   [#object_id]      The actual value.
    # @param error    [Exception, nil]  Any raised exception.
    # @param got      [Boolean, nil]    Any returned value.
    # @param matcher  [#matches?]       The matcher.
    # @param negate   [Boolean]         The assertion is positive or negative.
    # @param valid    [Boolean]         The result of an expectation.
    #
    # @return [nil] Write a message to STDOUT.
    #
    # @raise [SystemExit] Terminate execution immediately by calling
    #   `Kernel.exit(false)` with a failure message written to STDERR.
    def result(actual:, error:, got:, matcher:, negate:, valid:)
      puts "  " + ::Expresenter.call(valid).with(
        actual:   actual,
        error:    error,
        expected: matcher.expected,
        got:      got,
        negate:   negate,
        valid:    valid,
        matcher:  matcher.class.to_sym,
        level:    :MUST
      ).colored_string
    rescue ::Expresenter::Fail => e
      abort "  #{e.colored_string}"
    end
  end
end
