# frozen_string_literal: true

require "matchi/rspec"
require "securerandom"

module RSpec
  # Abstract class for handling the domain-specific language.
  class DSL
    # Run some shared setup before each of the specs in the describe in which it
    # is called.
    #
    # @param block [Proc] The content to execute at the class initialization.
    def self.before(&block)
      define_method(:initialize) do |*args, **kwargs|
        super()
        instance_exec(*args, **kwargs, &block)
      end
    end

    # Sets a user-defined property.
    #
    # @param block [Proc] The content of the method to define.
    # @return [Symbol] A protected method that define the block content.
    def self.let(name, &block)
      protected define_method(name.to_sym, &block)
    end

    # Sets a user-defined property named `subject`.
    #
    # @param block [Proc] The subject to set.
    # @return [Symbol] A `subject` method that define the block content.
    def self.subject(&block)
      let(__method__, &block)
    end

    # Create a group of specs.
    #
    # @param const [Module, #object_id] A module to include in block context.
    # @param block [Proc] The block to define the specs.
    def self.describe(const = nil, &block)
      desc = Sandbox.const_set(random_test_const_name, ::Class.new(self))

      if const.is_a?(::Module)
        desc.define_method(:described_class) { const }
        desc.send(:protected, :described_class)
      end

      desc.instance_eval(&block)
      desc
    end

    # Add `context` to the DSL.
    singleton_class.send(:alias_method, :context, :describe)

    # Define a single spec. A spec should contain one or more expectations that
    # test the state of the code.
    #
    # @param block [Proc] An expectation to evaluate.
    #
    # @raise (see ExpectationTarget::Base#result)
    # @return (see ExpectationTarget::Base#result)
    def self.it(_name = nil, &block)
      raise ::ArgumentError, "Missing block" unless block

      puts "\e[37m#{block.source_location.join(':')}\e[0m"

      i = example.new
      i.instance_eval(&block)
    end

    # @private
    #
    # @return [Class<DSL>] The class of the example to be tested.
    def self.example
      # Dynamic creation of an example class.
      ::Class.new(self) do
        # Include a collection of matchers.
        include ::Matchi::Helper

        private

        # Create an expectation for a spec.
        #
        # @param actual [#object_id] The actual value.
        #
        # @return [ExpectationTarget] The target of the expectation.
        def expect(actual = self.class.superclass, &block)
          ExpectationTarget.call(self.class.superclass, actual, block)
        end

        # Wraps the target of an expectation with the subject as actual value.
        #
        # @return [ExpectationTarget] (see #expect)
        def is_expected
          expect(subject)
        end

        # Mark a spec as pending, expectation results will be ignored.
        #
        # @param description [String] The reason why the example is pending.
        #
        # @return [nil] Write a message to STDOUT.
        def pending(description)
          Pending.result(description)
        end
      end
    end

    # @private
    #
    # @return [String] A random constant name for a test class.
    def self.random_test_const_name
      "Test#{::SecureRandom.hex(4).to_i(16)}"
    end

    private_class_method :example, :random_test_const_name
  end
end

require_relative "expectation_target"
require_relative "pending"
require_relative "sandbox"
