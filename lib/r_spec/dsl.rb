# frozen_string_literal: true

require "securerandom"

module RSpec
  # Abstract class for handling the domain-specific language.
  class Dsl
    # Instructs the spec runner to execute the given block before each spec in
    # the spec suite.
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
    # @param name   [String, Symbol] The name of the property.
    # @param block  [Proc] The content of the method to define.
    #
    # @return [Symbol] A protected method that define the block content.
    def self.let(name, *args, **kwargs, &block)
      protected define_method(name.to_sym, *args, **kwargs, &block)
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
    # @return [Class<Dsl>] The class of the example to be tested.
    def self.example
      ::Class.new(self) { include ExpectationHelper }
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

require_relative "expectation_helper"
require_relative "sandbox"
