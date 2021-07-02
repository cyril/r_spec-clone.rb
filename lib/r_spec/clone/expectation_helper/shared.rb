# frozen_string_literal: true

require "matchi/rspec"

require_relative File.join("..", "error", "pending_expectation")

module RSpec
  module Clone
    module ExpectationHelper
      # Abstract expectation helper base module.
      #
      # This module defines a number of methods to create expectations, which
      # are automatically included into examples.
      #
      # It also includes a collection of expectation matchers 🤹
      #
      # @example Equivalence matcher
      #   matcher = eql("foo") # => Matchi::Matcher::Eql.new("foo")
      #   matcher.matches? { "foo" } # => true
      #   matcher.matches? { "bar" } # => false
      #
      #   matcher = eq("foo") # => Matchi::Matcher::Eq.new("foo")
      #   matcher.matches? { "foo" } # => true
      #   matcher.matches? { "bar" } # => false
      #
      # @example Identity matcher
      #   object = "foo"
      #
      #   matcher = equal(object) # => Matchi::Matcher::Equal.new(object)
      #   matcher.matches? { object } # => true
      #   matcher.matches? { "foo" } # => false
      #
      #   matcher = be(object) # => Matchi::Matcher::Be.new(object)
      #   matcher.matches? { object } # => true
      #   matcher.matches? { "foo" } # => false
      #
      # @example Regular expressions matcher
      #   matcher = match(/^foo$/) # => Matchi::Matcher::Match.new(/^foo$/)
      #   matcher.matches? { "foo" } # => true
      #   matcher.matches? { "bar" } # => false
      #
      # @example Expecting errors matcher
      #   matcher = raise_exception(NameError) # => Matchi::Matcher::RaiseException.new(NameError)
      #   matcher.matches? { Boom } # => true
      #   matcher.matches? { true } # => false
      #
      # @example Truth matcher
      #   matcher = be_true # => Matchi::Matcher::BeTrue.new
      #   matcher.matches? { true } # => true
      #   matcher.matches? { false } # => false
      #   matcher.matches? { nil } # => false
      #   matcher.matches? { 4 } # => false
      #
      # @example Untruth matcher
      #   matcher = be_false # => Matchi::Matcher::BeFalse.new
      #   matcher.matches? { false } # => true
      #   matcher.matches? { true } # => false
      #   matcher.matches? { nil } # => false
      #   matcher.matches? { 4 } # => false
      #
      # @example Nil matcher
      #   matcher = be_nil # => Matchi::Matcher::BeNil.new
      #   matcher.matches? { nil } # => true
      #   matcher.matches? { false } # => false
      #   matcher.matches? { true } # => false
      #   matcher.matches? { 4 } # => false
      #
      # @example Type/class matcher
      #   matcher = be_instance_of(String) # => Matchi::Matcher::BeInstanceOf.new(String)
      #   matcher.matches? { "foo" } # => true
      #   matcher.matches? { 4 } # => false
      #
      #   matcher = be_an_instance_of(String) # => Matchi::Matcher::BeAnInstanceOf.new(String)
      #   matcher.matches? { "foo" } # => true
      #   matcher.matches? { 4 } # => false
      #
      # @see https://github.com/fixrb/matchi
      # @see https://github.com/fixrb/matchi-rspec
      module Shared
        include ::Matchi::Helper
      end
    end
  end
end
