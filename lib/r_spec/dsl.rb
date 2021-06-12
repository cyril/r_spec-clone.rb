# frozen_string_literal: true

require "securerandom"

require_relative "console"
require_relative "error"
require_relative "expectation_helper"
require_relative "sandbox"

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
      desc = Sandbox.const_set(random_context_const_name, ::Class.new(self))

      if const.is_a?(::Module)
        desc.define_method(:described_class) { const }
        desc.send(:protected, :described_class)
      end

      desc.instance_eval(&block)
      desc
    end

    # Add `context` to the DSL.
    singleton_class.send(:alias_method, :context, :describe)

    # Use the `it` method to define a single spec. A spec should contain one or
    # more expectations that test the state of the code.
    #
    # @example The integer after 41
    #   require "r_spec"
    #
    #   RSpec.describe Integer do
    #     it { expect(41.next).to be 42 }
    #   end
    #
    #   # Output to the console
    #   #   Success: expected to be 42.
    #
    # @example A division by zero
    #   require "r_spec"
    #
    #   RSpec.describe Integer do
    #     subject { 41 }
    #
    #     it { is_expected.to be_an_instance_of described_class }
    #
    #     it "raises an error" do
    #       expect { subject / 0 }.to raise_exception ZeroDivisionError
    #     end
    #   end
    #
    #   # Output to the console
    #   #   Success: expected 41 to be an instance of Integer.
    #   #   Success: divided by 0.
    #
    # @param _name [String, nil] The name of the spec.
    # @param block [Proc] An expectation to evaluate.
    #
    # @raise (see ExpectationTarget::Base#result)
    # @return (see ExpectationTarget::Base#result)
    def self.it(_name = nil, &block)
      raise ::ArgumentError, "Missing example block" unless block

      i = it_example.new
      i.instance_eval(&block)
    rescue ::SystemExit
      Console.source(*block.source_location)

      exit false
    end

    # Mark a spec as pending, expectation results will be ignored.
    #
    # @param message [String] The reason why the example is pending.
    #
    # @return [nil] Write a message to STDOUT.
    #
    # @example Output a message to the console and return nil
    #   pending("something else getting finished") # => nil
    #
    #   # Output to the console
    #   #   Warning: something else getting finished.
    #
    # @api public
    def self.pending(message)
      Console.passed_spec Error::PendingExpectation.result(message)
    end

    # Use the `its` method to define a single spec that specifies the actual
    # value of an attribute of the subject using `is_expected`.
    #
    # @example The integer after 41
    #   require "r_spec"
    #
    #   RSpec.describe Integer do
    #     subject { 41 }
    #
    #     its(:next) { is_expected.to be 42 }
    #   end
    #
    #   # Output to the console
    #   #   Success: expected to be 42.
    #
    # @example A division by zero
    #   require "r_spec"
    #
    #   RSpec.describe Integer do
    #     subject { 41 }
    #
    #     its(:/, 0) { is_expected.to raise_exception ZeroDivisionError }
    #   end
    #
    #   # Output to the console
    #   #   Success: divided by 0.
    #
    # @example A spec without subject
    #   require "r_spec"
    #
    #   RSpec.describe Integer do
    #     its(:boom) { is_expected.to raise_exception RSpec::Error::UndefinedSubject }
    #   end
    #
    #   # Output to the console
    #   #   Success: subject not explicitly defined.
    #
    # @param attribute [String, Symbol] The property to call to subject.
    # @param args [Array] An optional list of arguments.
    # @param kwargs [Hash] An optional list of keyword arguments.
    # @param block [Proc] An expectation to evaluate.
    #
    # @raise (see ExpectationTarget::Base#result)
    # @return (see ExpectationTarget::Base#result)
    def self.its(attribute, *args, **kwargs, &block)
      raise ::ArgumentError, "Missing example block" unless block

      i = its_example.new

      i.define_singleton_method(:actual) do
        subject.public_send(attribute, *args, **kwargs)
      end

      i.instance_eval(&block)
    rescue ::SystemExit
      Console.source(*block.source_location)

      exit false
    end

    # @private
    #
    # @return [Class<Dsl>] The class of the example to be tested.
    def self.it_example
      ::Class.new(self) { include ExpectationHelper::It }
    end

    # @private
    #
    # @return [Class<Dsl>] The class of the example to be tested.
    def self.its_example
      ::Class.new(self) { include ExpectationHelper::Its }
    end

    # @private
    #
    # @return [String] A random constant name for a test class.
    def self.random_context_const_name
      "Context#{::SecureRandom.hex(4).to_i(16)}"
    end

    private_class_method :it_example, :its_example, :random_context_const_name

    protected

    def described_class
      raise Error::UndefinedDescribedClass,
            "the first argument to at least one example group must be a module"
    end

    def subject
      raise Error::UndefinedSubject, "subject not explicitly defined"
    end
  end
end
