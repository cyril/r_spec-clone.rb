# frozen_string_literal: true

require_relative "console"
require_relative "error"
require_relative "expectation_helper"

module RSpec
  module Clone
    # Abstract class for handling the domain-specific language.
    class Dsl
      BEFORE_METHOD = :initialize
      AFTER_METHOD  = :terminate

      private_constant :BEFORE_METHOD, :AFTER_METHOD

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
      #
      # @api public
      def self.before(&block)
        define_method(BEFORE_METHOD) do
          super()
          instance_eval(&block)
        end

        private BEFORE_METHOD
      end

      # Executes the given block after each spec in the current context runs.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe Integer do
      #     after do
      #       puts "That is the answer to everything."
      #     end
      #
      #     it { expect(42).to be 42 }
      #   end
      #
      #   # Output to the console
      #   #   Success: expected to be 42.
      #   #   That is the answer to everything.
      #
      # @param block [Proc] The content to execute at the class initialization.
      #
      # @api public
      def self.after(&block)
        define_method(AFTER_METHOD) do
          instance_exec(&block)
          super()
        end

        private AFTER_METHOD
      end

      # Sets a user-defined property.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe "Name stories" do
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
      # @return [Symbol] A private method that define the block content.
      #
      # @api public
      def self.let(name, *args, **kwargs, &block)
        raise Error::ReservedMethod if [BEFORE_METHOD, AFTER_METHOD].include?(name.to_sym)

        private define_method(name, *args, **kwargs, &block)
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
      #
      #     it { is_expected.to be_an_instance_of described_class }
      #
      #     its(:size) { is_expected.to be 3 }
      #     its(:downcase) { is_expected.to raise_exception NoMethodError }
      #   end
      #
      #   # Output to the console
      #   #   Success: expected to eq [1, 2, 3].
      #   #   Success: expected [1, 2, 3] to be an instance of Array.
      #   #   Success: expected to be 3.
      #   #   Success: undefined method `downcase' for [1, 2, 3]:Array.
      #
      # @param block [Proc] The subject to set.
      # @return [Symbol] A {#subject} method that define the block content.
      #
      # @api public
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
      # @param const [Module, String] A module to include in block context.
      # @param block [Proc] The block to define the specs.
      #
      # @api public
      def self.describe(const, &block)
        desc = ::Class.new(self)
        desc.let(:described_class) { const } if const.is_a?(::Module)
        desc.instance_eval(&block)
      end

      # :nocov:

      # Runs a describe example group in a subprocess to isolate side effects.
      #
      # @example
      #   $app = "foo"
      #
      #   require "r_spec"
      #
      #   RSpec.describe "Scoped side effects" do
      #     describe! "#gsub!" do
      #       before do
      #         $app.gsub!("o", "0")
      #       end
      #
      #       context! "when isolated in the context" do
      #         before do
      #           $app.gsub!("f", "F")
      #         end
      #
      #         it { expect($app).to eq "F00" }
      #       end
      #
      #       it { expect($app).to eq "f00" }
      #     end
      #
      #     it { expect($app).to eq "foo" }
      #   end
      #
      #   # Output to the console
      #   #   Success: expected to eq "F00".
      #   #   Success: expected to eq "f00".
      #   #   Success: expected to eq "foo".
      #
      # @param (see #describe)
      #
      # @api public
      def self.describe!(const, &block)
        fork! { describe(const, &block) }
      end

      # :nocov:

      # Defines an example group that establishes a specific context, like
      # _empty array_ versus _array with elements_.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe "web resource" do
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
      #
      # @api public
      def self.context(_description, &block)
        desc = ::Class.new(self)
        desc.instance_eval(&block)
      end

      # :nocov:

      # Runs a context example group in a subprocess to isolate side effects.
      #
      # @example
      #   app = "Hello, world!"
      #
      #   require "r_spec"
      #
      #   RSpec.describe String do
      #     subject do
      #       app
      #     end
      #
      #     before do
      #       subject.gsub!("world", person)
      #     end
      #
      #     context! "when Alice is greeted" do
      #       let(:person) { "Alice" }
      #
      #       it { is_expected.to eq "Hello, Alice!" }
      #     end
      #
      #     context! "when Bob is greeted" do
      #       let(:person) { "Bob" }
      #
      #       it { is_expected.to eq "Hello, Bob!" }
      #     end
      #   end
      #
      #   # Output to the console
      #   #   Success: expected to eq "Hello, Alice!".
      #   #   Success: expected to eq "Hello, Bob!".
      #
      # @param (see #context)
      #
      # @api public
      def self.context!(description, &block)
        fork! { context(description, &block) }
      end

      # :nocov:

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
      #
      # @api public
      def self.it(_name = nil, &block)
        run(example_without_attribute.new, &block)
      end

      # :nocov:

      # Runs a concrete test case in a subprocess to isolate side effects.
      #
      # @example
      #   app = "foo"
      #
      #   require "r_spec"
      #
      #   RSpec.describe "Side effects per example" do
      #     it! "runs the example in isolation" do
      #       expect { app.gsub!("foo", "bar") }.to eq "bar"
      #       expect(app).to eq "bar"
      #     end
      #
      #     it "runs the example" do
      #       expect(app).to eq "foo"
      #     end
      #   end
      #
      #   # Output to the console
      #   #   Success: expected to eq "bar".
      #   #   Success: expected to eq "bar".
      #   #   Success: expected to eq "foo".
      #
      # @param (see #it)
      #
      # @raise (see ExpectationTarget::Base#result)
      # @return (see ExpectationTarget::Base#result)
      #
      # @api public
      def self.it!(name = nil, &block)
        fork! { it(name, &block) }
      end

      # :nocov:

      # Defines a single concrete test case that specifies the actual value of
      # an attribute of the subject using {ExpectationHelper::Its#is_expected}.
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
      #     its(:abs) { is_expected.to raise_exception RSpec::Clone::Error::UndefinedSubject }
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
      #
      # @api public
      def self.its(attribute, *args, **kwargs, &block)
        run(example_with_attribute(attribute, *args, **kwargs).new, &block)
      end

      # :nocov:

      # Runs a single concrete test case in a subprocess to isolate side
      # effects.
      #
      # @example
      #   app = "foo"
      #
      #   require "r_spec"
      #
      #   RSpec.describe "Isolated side effect" do
      #     subject do
      #       app
      #     end
      #
      #     its!(:upcase) { is_expected.to eq "FOO" }
      #
      #     it "tests the original value" do
      #       expect(app).to eq "foo"
      #     end
      #   end
      #
      #   # Output to the console
      #   #   Success: expected to eq "FOO".
      #   #   Success: expected to eq "foo".
      #
      # @param (see #it)
      #
      # @raise (see ExpectationTarget::Base#result)
      # @return (see ExpectationTarget::Base#result)
      #
      # @api public
      def self.its!(attribute, *args, **kwargs, &block)
        fork! { its(attribute, *args, **kwargs, &block) }
      end

      # :nocov:

      # Defines a pending test case.
      #
      # `&block` is never evaluated. It can be used to describe behaviour that
      # is not yet implemented.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe "an example" do
      #     pending "is implemented but waiting" do
      #       expect something to be finished
      #     end
      #
      #     pending "is not yet implemented and waiting"
      #   end
      #
      #   # Output to the console
      #   #   Warning: is implemented but waiting.
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

      # Example class for concrete test case.
      def self.example_without_attribute
        ::Class.new(self) do
          prepend ExpectationHelper::It
        end
      end

      # Example class for concrete test case that specifies the actual value of
      # an attribute of the subject.
      def self.example_with_attribute(attribute, *args, **kwargs)
        ::Class.new(self) do
          prepend ExpectationHelper::Its

          define_method(:actual) do
            subject.public_send(attribute, *args, **kwargs)
          end
        end
      end

      # Creates a subprocess and runs the block inside.
      def self.fork!(&block)
        pid = fork(&block)
        thread = ::Process.detach(pid)
        exitstatus = thread.join.value.exitstatus
        exit false unless exitstatus.zero?
      end

      # Execution of specifications.
      def self.run(example, &block)
        example.instance_eval(&block)
      rescue ::SystemExit
        Console.source(*block.source_location)

        exit false
      ensure
        example&.send(AFTER_METHOD)
      end

      private_class_method :example_without_attribute, :example_with_attribute, :fork!, :run

      private

      # If the first argument to a {.describe} definition is a class (or a
      # module), this method will be overridden to return it.
      def described_class
        raise Error::UndefinedDescribedClass,
              "the first argument to at least one example group must be a module"
      end

      # If a subject is defined, this method will be overridden to return it.
      def subject
        raise Error::UndefinedSubject, "subject not explicitly defined"
      end

      define_method(AFTER_METHOD) do
        # do nothing by default
      end
    end
  end
end
