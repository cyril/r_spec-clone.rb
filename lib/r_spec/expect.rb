# frozen_string_literal: true

module RSpec
  class Expect
    def initialize(actual)
      @actual = actual
    end

    def to(matcher)
      Requirement.new(actual: @actual, negate: false, matcher: matcher).call
    end

    def not_to(matcher)
      Requirement.new(actual: @actual, negate: true, matcher: matcher).call
    end
  end
end
