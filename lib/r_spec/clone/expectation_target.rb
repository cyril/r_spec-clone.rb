# frozen_string_literal: true

require "spectus"

require_relative "report"

module RSpec
  module Clone
    # The target of an expectation: what `expect` wraps, judged by `to` or
    # `not_to` with a matcher. Every expectation is a MUST of Spectus: the
    # block is called in the requirement, where what it returns or raises
    # is kept for the matcher, and the result is written at once.
    class ExpectationTarget
      # @param callable [#call] gives the actual value: the block of
      #   `expect { … }`, or a lambda holding the value of `expect(…)`
      def initialize(callable)
        @callable = callable
      end

      # Passes when the matcher matches the actual value.
      #
      # @example
      #   expect { "foo".upcase }.to eq("FOO")
      #
      # @param matcher [#match?] the matcher
      # @return [nil]
      # @raise [ArgumentError] when the matcher does not respond to `match?`
      # @raise [TypeError] when the `to_s` of the matcher is not a String
      # @raise [SystemExit] when the expectation is not met
      def to(matcher)
        judge(::Spectus.must(matcher))
      end

      # Passes when the matcher does not match the actual value.
      #
      # @example
      #   expect { "foo".size }.not_to be(4)
      #
      # @param (see #to)
      # @return (see #to)
      # @raise (see #to)
      def not_to(matcher)
        judge(::Spectus.must_not(matcher))
      end

      private

      # Judges the actual value, and writes the result where the expectation
      # is written: the caller of `to` or `not_to`. A process the block
      # forked and let run on, instead of ending it with exit!, is not the
      # one that writes: it leaves here without a word.
      def judge(requirement)
        location = Report.location
        pid = ::Process.pid
        result = requirement.call(&@callable)
        ::Process.exit! unless ::Process.pid == pid

        Report.result(location, result)
      end
    end
  end
end
