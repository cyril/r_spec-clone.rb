# frozen_string_literal: true

require "securerandom"

require_relative "console"
require_relative "error"
require_relative "expectation_helper"
require_relative "sandbox"

module RSpec
  # Abstract class for handling the domain-specific language.
  class Dsl
    # Executes the given block before each spec in the current context runs.
    #
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe Integer do
    #     before do
    #       @value = 123
    #     end
    #
    #     it { expect(@value).to be 123 }
    #
    #     describe "nested" do
    #       before do
    #         @value -= 81
    #       end
    #
    #       it { expect(@value).to be 42 }
    #     end
    #
    #     it { expect(@value).to be 123 }
    #   end
    #
    #   # Output to the console
    #   #   Success: expected to be 123.
    #   #   Success: expected to be 42.
    #   #   Success: expected to be 123.
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
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe do
    #     let(:name) { "Bob" }
    #
    #     it { expect(name).to eq "Bob" }
    #
    #     context "with last name" do
    #       let(:name) { "#{super()} Smith" }
    #
    #       it { expect(name).to eq "Bob Smith" }
    #     end
    #   end
    #
    #   # Output to the console
    #   #   Success: expected to eq "Bob".
    #   #   Success: expected to eq "Bob Smith".
    #
    # @param name   [String, Symbol] The name of the property.
    # @param block  [Proc] The content of the method to define.
    #
    # @return [Symbol] A protected method that define the block content.
    def self.let(name, *args, **kwargs, &block)
      protected define_method(name.to_sym, *args, **kwargs, &block)
    end

    # Sets a user-defined property named {#subject}.
    #
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe Array do
    #     subject { [1, 2, 3] }
    #
    #     it "has the prescribed elements" do
    #       expect(subject).to eq([1, 2, 3])
    #     end
    #   end
    #
    #   # Output to the console
    #   #   Success: expected to eq [1, 2, 3].
    #
    # @param block [Proc] The subject to set.
    # @return [Symbol] A {#subject} method that define the block content.
    def self.subject(&block)
      let(__method__, &block)
    end

    # Defines an example group that describes a unit to be tested.
    #
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe String do
    #     describe "+" do
    #       it("concats") { expect("foo" + "bar").to eq "foobar" }
    #     end
    #   end
    #
    #   # Output to the console
    #   #   Success: expected to eq "foobar".
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

    # Defines an example group that establishes a specific context, like _empty
    # array_ versus _array with elements_.
    #
    # It is functionally equivalent to {.describe}.
    #
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe do
    #     context "when resource is not found" do
    #       pending "responds with 404"
    #     end
    #
    #     context "when resource is found" do
    #       pending "responds with 200"
    #     end
    #   end
    #
    #   # Output to the console
    #   #   Warning: responds with 404.
    #   #   Warning: responds with 200.
    #
    # @param _description [String] A description that usually begins with
    #   "when", "with" or "without".
    # @param block [Proc] The block to define the specs.
    def self.context(_description = nil, &block)
      desc = Sandbox.const_set(random_context_const_name, ::Class.new(self))
      desc.instance_eval(&block)
      desc
    end

    # Defines a concrete test case.
    #
    # The test is performed by the block supplied to `&block`.
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
    # It can be used inside a {.describe} or {.context} section.
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

    # Use the {.its} method to define a single spec that specifies the actual
    # value of an attribute of the subject using
    # {ExpectationHelper::Its#is_expected}.
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

    # Defines a pending test case.
    #
    # `&block` is never evaluated. It can be used to describe behaviour that is
    # not yet implemented.
    #
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe do
    #     pending "is implemented but waiting" do
    #       expect("something").to eq("getting finished")
    #     end
    #   end
    #
    #   # Output to the console
    #   #   Warning: is implemented but waiting.
    #
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe do
    #     pending "is not yet implemented and waiting"
    #   end
    #
    #   # Output to the console
    #   #   Warning: is not yet implemented and waiting.
    #
    # @param message [String] The reason why the example is pending.
    #
    # @return [nil] Write a message to STDOUT.
    #
    # @api public
    def self.pending(message)
      Console.passed_spec Error::PendingExpectation.result(message)
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
