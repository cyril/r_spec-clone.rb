# frozen_string_literal: true

require "matchi"

module RSpec
  module Clone
    module ExpectationHelper
      # The matchers of an example, as words: each one builds a matcher of
      # Matchi, which raises `ArgumentError` for an argument it refuses. The
      # expected value is always the one that receives the comparison, so
      # that the actual value cannot vouch for itself.
      #
      # @see https://github.com/fixrb/matchi
      module Matcher
        # @param expected [Object] the expected value
        # @return [Matchi::Eq] `eql?` to the expected value, of its class
        def eq(expected)
          ::Matchi::Eq.new(expected)
        end

        alias eql eq

        # @param expected [Object] the expected object
        # @return [Matchi::Be] the very same object
        def be(expected)
          ::Matchi::Be.new(expected)
        end

        alias equal be

        # @param delta [Numeric] the tolerance
        # @return [Matchi::BeWithin] to complete with `of(expected)`
        def be_within(delta)
          ::Matchi::BeWithin.new(delta)
        end

        # @param expected [Regexp] the pattern
        # @return [Matchi::Match] a String or a Symbol matching the pattern
        def match(expected)
          ::Matchi::Match.new(expected)
        end

        # @param expected [Class, String, Symbol] the exception class, or its name
        # @param message [String, Regexp, nil] the expected message
        # @return [Matchi::RaiseException] raising that exception
        def raise_exception(expected, message = nil)
          ::Matchi::RaiseException.new(expected, message)
        end

        # @return [Matchi::Be] `true` itself
        def be_true
          ::Matchi::Be.new(true)
        end

        # @return [Matchi::Be] `false` itself
        def be_false
          ::Matchi::Be.new(false)
        end

        # @return [Matchi::Be] `nil` itself
        def be_nil
          ::Matchi::Be.new(nil)
        end

        # @param expected [Class, String, Symbol] the class, or its name
        # @return [Matchi::BeAnInstanceOf] an instance of that very class
        def be_an_instance_of(expected)
          ::Matchi::BeAnInstanceOf.new(expected)
        end

        # @param expected [Module, String, Symbol] the module, or its name
        # @return [Matchi::BeAKindOf] an instance of that module or of a descendant
        def be_a_kind_of(expected)
          ::Matchi::BeAKindOf.new(expected)
        end

        # @param object [Object] the object to observe
        # @param method [Symbol, String] the method whose value may change,
        #   followed by its arguments and its block
        # @return [Matchi::Change] a change, or one to refine with `by`,
        #   `by_at_least`, `by_at_most`, `from … to` or `to`
        def change(object, method, ...)
          ::Matchi::Change.new(object, method, ...)
        end

        # @yieldparam value [Object] the actual value
        # @yieldreturn [Boolean] whether it satisfies the block
        # @return [Matchi::Satisfy]
        def satisfy(&)
          ::Matchi::Satisfy.new(&)
        end

        private

        # A predicate matcher for a name that starts with `be_` or `have_`:
        # `be_empty` asks `empty?`, `have_key(:a)` asks `has_key?(:a)`.
        def method_missing(name, ...)
          return super unless predicate?(name)

          ::Matchi::Predicate.new(name, ...)
        end

        def respond_to_missing?(name, include_private = false)
          predicate?(name) || super
        end

        # Whether a name is the one of a predicate matcher, as Matchi
        # accepts it.
        def predicate?(name)
          ::Matchi::Predicate::NAME.match?(name)
        end
      end
    end
  end
end
