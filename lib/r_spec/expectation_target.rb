# frozen_string_literal: true

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
    # @example
    #   expect(value).to be(42)
    #
    # @param matcher [#matches?] The matcher.
    def to(matcher)
      AbsoluteRequirement.new(actual: @actual, matcher: matcher, negate: false).call
    end

    # Runs the given expectation, passing if `matcher` returns false.
    #
    # @example
    #   expect(value).not_to be(4)
    #
    # @param (see #to)
    def not_to(matcher)
      AbsoluteRequirement.new(actual: @actual, matcher: matcher, negate: true).call
    end
  end
end

require_relative "absolute_requirement"
