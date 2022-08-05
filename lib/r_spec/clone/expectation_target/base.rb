# frozen_string_literal: true

require "expresenter"
require "test_tube"

require_relative File.join("..", "logger")

module RSpec
  module Clone
    module ExpectationTarget
      # Abstract expectation target base class.
      #
      # @note `RSpec::Clone::ExpectationTarget::Base` is not intended to be
      #   instantiated directly by users. Use `expect` instead.
      class Base
        # Instantiate a new expectation target.
        #
        # @param input [#object_id, Proc] The code to evaluate.
        def initialize(input)
          @input = input
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
        #
        # @api public
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
        #
        # @api public
        def not_to(matcher)
          absolute_requirement(matcher: matcher, negate: true)
        end

        protected

        # @param test     [::TestTube::Base] The state of the experiment.
        # @param matcher  [#matches?] The matcher.
        # @param negate   [Boolean]   The assertion is positive or negative.
        #
        # @return [nil] Write a message to STDOUT.
        #
        # @raise [SystemExit] Terminate execution immediately by calling
        #   `Kernel.exit(false)` with a failure message written to STDERR.
        def absolute_requirement(test, matcher:, negate:)
          result(
            passed?(test),
            actual:  test.actual,
            error:   test.error,
            got:     test.got,
            matcher: matcher,
            negate:  negate
          )
        end

        # Code experiment result.
        #
        # @param test [::TestTube::Base] The state of the experiment.
        #
        # @see https://github.com/fixrb/test_tube
        #
        # @return [Boolean] The result of the test (passed or failed).
        def passed?(test)
          test.got.equal?(true)
        end

        # :nocov:

        # @param passed   [Boolean]         The high expectation passed or failed.
        # @param actual   [#object_id]      The actual value.
        # @param error    [Exception, nil]  Any raised exception.
        # @param got      [Boolean, nil]    Any returned value.
        # @param matcher  [#matches?]       The matcher.
        # @param negate   [Boolean]         The assertion is positive or negative.
        #
        # @return [nil] Write a message to STDOUT.
        #
        # @raise [SystemExit] Terminate execution immediately by calling
        #   `Kernel.exit(false)` with a failure message written to STDERR.
        def result(passed, actual:, error:, got:, matcher:, negate:)
          Logger.passed_spec ::Expresenter.call(passed).with(
            actual:     actual,
            definition: matcher.to_s,
            error:      error,
            expected:   matcher.expected,
            got:        got,
            negate:     negate,
            level:      :MUST
          )
        rescue ::Expresenter::Fail => e
          Logger.failed_spec(e)
        end

        # :nocov:
      end
    end
  end
end
