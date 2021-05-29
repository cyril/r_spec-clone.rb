# frozen_string_literal: true

module RSpec
  class Expect
    def initialize(actual)
      @actual = actual
    end

    def to(matcher)
      Requirement.new(actual: @actual, matcher: matcher, negate: false).call
    end

    def not_to(matcher)
      Requirement.new(actual: @actual, matcher: matcher, negate: true).call
    end
  end
end

require_relative "requirement"
