# frozen_string_literal: true

require "matchi/rspec"

module RSpec
  # This module defines a number of methods to create expectations, which are
  # automatically included into example namespaces.
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
  # @see https://github.com/fixrb/matchi
  # @see https://github.com/fixrb/matchi-rspec
  module ExpectationHelper
    include ::Matchi::Helper

    # Create an expectation for a spec.
    #
    # @param value [#object_id, nil]  An actual value.
    # @param block [#call, nil]       A code to evaluate.
    #
    # @return [Block, Value] The wrapped target of an expectation.
    #
    # @example
    #   expect("foo") # => #<RSpec::ExpectationTarget::Value:0x00007fb6b82311a0 @actual="foo">
    #   expect { Boom } # => #<RSpec::ExpectationTarget::Block:0x00007fb6b8263df8 @callable=#<Proc:0x00007fb6b8263e20>>
    #
    # @api public
    def expect(value = self.class.superclass, &block)
      ExpectationTarget.call(self.class.superclass, value, block)
    end

    # Wraps the target of an expectation with the subject as actual value.
    #
    # @return (see #expect)
    #
    # @example In the case where a subject was previously declared with the value 42
    #   is_expected # => #<RSpec::ExpectationTarget::Value:0x00007fc14f904b70 @actual=42>
    #
    # @api public
    def is_expected
      expect(subject)
    end

    # Mark a spec as pending, expectation results will be ignored.
    #
    # @param description [String] The reason why the example is pending.
    #
    # @return [nil] Write a message to STDOUT.
    #
    # @example Output a message to the console and return nil
    #   pending("something else getting finished") # => nil
    #
    # @api public
    def pending(description)
      Pending.result(description)
    end
  end
end

require_relative "expectation_target"
require_relative "pending"
