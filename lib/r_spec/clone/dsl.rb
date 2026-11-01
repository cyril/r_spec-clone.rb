# frozen_string_literal: true

require "defi"

require_relative "error"
require_relative "expectation_helper"
require_relative "report"

module RSpec
  module Clone
    # The language of a spec. An example group, `describe` or `context`, is
    # a subclass of the enclosing one; `let`, `subject` and `before` define
    # methods on it, which a nested group inherits and may redefine, with
    # `super` at hand; an example is an instance of a class of its own,
    # built when `it` or `its` runs it, in the order of the file.
    #
    # @example
    #   require "r_spec"
    #
    #   RSpec.describe "Name stories" do
    #     let(:name) { "Bob" }
    #
    #     it { expect(name).to eq "Bob" }
    #
    #     context "with a last name" do
    #       let(:name) { "#{super()} Smith" }
    #
    #       it { expect(name).to eq "Bob Smith" }
    #     end
    #   end
    #
    #   # spec/name_spec.rb:6: Success: expected "Bob" to eq "Bob"
    #   # spec/name_spec.rb:11: Success: expected "Bob Smith" to eq "Bob Smith"
    class Dsl
      BEFORE_METHOD = :initialize
      # The words of an example, which a helper cannot take.
      WORDS = ExpectationHelper::It

      private_constant :BEFORE_METHOD, :WORDS

      # Runs the block before each example of the group, after the blocks
      # of the enclosing groups and those written before it in the group,
      # in the example itself: an instance variable set here is seen by the
      # example. Each block is the hook of a module of its own, included in
      # the group, so that the blocks chain through `super`.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe Integer do
      #     before { @value = 123 }
      #
      #     it { expect(@value).to be 123 }
      #
      #     describe "nested" do
      #       before { @value -= 81 }
      #
      #       it { expect(@value).to be 42 }
      #     end
      #   end
      #
      #   # spec/before_spec.rb:6: Success: expected 123 to be 123
      #   # spec/before_spec.rb:11: Success: expected 42 to be 42
      #
      # @yield the block to run before each example
      # @return [nil]
      # @raise [ArgumentError] without a block
      #
      # @api public
      def self.before(&block)
        raise ::ArgumentError, "a block must be given" unless block

        hook = ::Module.new do
          define_method(BEFORE_METHOD) do
            super()
            instance_eval(&block)
          end
        end
        include hook
        nil
      end

      # Defines a helper method, called each time it is used: nothing is
      # memoized.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe Integer do
      #     let(:answer) { 42 }
      #
      #     it { expect(answer).to be 42 }
      #
      #     context "when incremented" do
      #       let(:answer) { super().next }
      #
      #       it { expect(answer).to be 43 }
      #     end
      #   end
      #
      #   # spec/let_spec.rb:6: Success: expected 42 to be 42
      #   # spec/let_spec.rb:11: Success: expected 43 to be 43
      #
      # @param name [Symbol, String] the name of the helper
      # @yield the body of the helper, with its parameters
      # @return [Symbol] the name of the helper
      # @raise [Error::ReservedMethod] for the name of the hook, or a word
      #   of the example (`expect`, `is_expected`, a matcher), which the
      #   helper could not reach
      #
      # @api public
      def self.let(name, ...)
        name = name.to_sym
        reserved = BEFORE_METHOD.equal?(name) || WORDS.method_defined?(name) || WORDS.private_method_defined?(name)
        raise Error::ReservedMethod, "#{name} is reserved" if reserved

        private define_method(name, ...)
      end

      # Defines the subject, a helper named `subject`.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe Array do
      #     subject { [1, 2, 3] }
      #
      #     it { expect(subject).to eq [1, 2, 3] }
      #     it { is_expected.to be_an_instance_of described_class }
      #     its(:size) { is_expected.to be 3 }
      #   end
      #
      #   # spec/subject_spec.rb:6: Success: expected [1, 2, 3] to eq [1, 2, 3]
      #   # spec/subject_spec.rb:7: Success: expected [1, 2, 3] to be an instance of Array
      #   # spec/subject_spec.rb:8: Success: expected 3 to be 3
      #
      # @yield the body of the subject
      # @return [Symbol] `:subject`
      #
      # @api public
      def self.subject(&)
        let(__method__, &)
      end

      # Defines an example group that describes a unit to be tested. A
      # module given makes `described_class` return it.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe String do
      #     describe "#+" do
      #       it("concatenates") { expect("foo" + "bar").to eq "foobar" }
      #     end
      #   end
      #
      #   # spec/string_spec.rb:5: Success: expected "foobar" to eq "foobar"
      #
      # @param const [Module, String] the module under test, or a description
      # @yield the specs of the group
      # @return [nil]
      # @raise [ArgumentError] without a block
      #
      # @api public
      def self.describe(const, &block)
        raise ::ArgumentError, "a block must be given" unless block

        group = ::Class.new(self)
        group.let(:described_class) { const } if ::Module === const
        group.instance_eval(&block)
        nil
      end

      # Defines an example group that establishes a context, like _empty
      # array_ versus _array with elements_, and runs it in a child process:
      # what its specs change in the Ruby process, a constant, a global, the
      # subject itself, stays in the child. The parent exits with the status
      # 1 when the child did not succeed.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe "a web resource" do
      #     context "when it is not found" do
      #       pending "responds with 404"
      #     end
      #
      #     context "when it is found" do
      #       pending "responds with 200"
      #     end
      #   end
      #
      #   # spec/resource_spec.rb:5: Pending: responds with 404
      #   # spec/resource_spec.rb:9: Pending: responds with 200
      #
      # @param _description [String] a description, usually beginning with
      #   "when", "with" or "without"
      # @yield the specs of the context
      # @return [nil]
      # @raise [ArgumentError] without a block
      # @raise [NotImplementedError] when this Ruby cannot fork
      # @raise [SystemExit] when a spec of the context did not succeed
      #
      # @api public
      def self.context(_description, &block)
        raise ::ArgumentError, "a block must be given" unless block

        pid = ::Process.fork { ::Class.new(self).instance_eval(&block) }
        exit(false) unless ::Process.wait2(pid).last.success?
        nil
      end

      # Defines a concrete test case, and runs it: the block is evaluated
      # in a new example, where `expect`, `is_expected` and the matchers
      # are words.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe Integer do
      #     subject { 41 }
      #
      #     it { is_expected.to be_an_instance_of described_class }
      #
      #     it "raises on a division by zero" do
      #       expect { subject / 0 }.to raise_exception ZeroDivisionError
      #     end
      #   end
      #
      #   # spec/integer_spec.rb:6: Success: expected 41 to be an instance of Integer
      #   # spec/integer_spec.rb:9: Success: expected #<ZeroDivisionError: divided by 0> to raise exception ZeroDivisionError
      #
      # @param _name [String, nil] the name of the example
      # @yield the example, with its expectations
      # @return [nil]
      # @raise [ArgumentError] without a block
      # @raise [SystemExit] when an expectation is not met
      #
      # @api public
      def self.it(_name = nil, &block)
        raise ::ArgumentError, "a block must be given" unless block

        ::Class.new(self) { prepend ExpectationHelper::It }.new.instance_eval(&block)
        nil
      end

      # Defines a concrete test case about an attribute of the subject, and
      # runs it: `is_expected`, the one word of the example with the
      # matchers, wraps the attribute, sent to the subject with the
      # arguments when the matcher asks for it, so that what it raises can
      # be expected too.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe Integer do
      #     subject { 41 }
      #
      #     its(:next) { is_expected.to be 42 }
      #     its(:/, 0) { is_expected.to raise_exception ZeroDivisionError }
      #   end
      #
      #   # spec/its_spec.rb:6: Success: expected 42 to be 42
      #   # spec/its_spec.rb:7: Success: expected #<ZeroDivisionError: divided by 0> to raise exception ZeroDivisionError
      #
      # @param attribute [Symbol] the method to send to the subject, followed
      #   by its arguments
      # @yield the example, with its expectation
      # @return [nil]
      # @raise [ArgumentError] without a block, or when the attribute is not
      #   a Symbol
      # @raise [SystemExit] when the expectation is not met
      #
      # @api public
      def self.its(attribute, *, **, &block)
        raise ::ArgumentError, "a block must be given" unless block

        challenge = ::Defi::Challenge.new(attribute, *, **)
        example = ::Class.new(self) do
          prepend ExpectationHelper::Matcher
          define_method(:is_expected) { ExpectationTarget.new(-> { challenge.to(subject).call }) }
        end
        example.new.instance_eval(&block)
        nil
      end

      # Defines a pending test case: its block, if any, is never run.
      #
      # @example
      #   require "r_spec"
      #
      #   RSpec.describe "an example" do
      #     pending "is implemented but waiting" do
      #       expect something to be finished
      #     end
      #
      #     pending "is not yet implemented"
      #   end
      #
      #   # spec/pending_spec.rb:4: Pending: is implemented but waiting
      #   # spec/pending_spec.rb:8: Pending: is not yet implemented
      #
      # @param message [String] why the example is pending
      # @yield never: the block is not run
      # @return [nil]
      #
      # @api public
      def self.pending(message, &)
        Report.pending(Report.location, message)
      end

      private

      # Overridden by `describe` when it is given a module.
      def described_class
        raise Error::UndefinedDescribedClass, "the first argument to at least one example group must be a module"
      end

      # Overridden by `subject`.
      def subject
        raise Error::UndefinedSubject, "subject not explicitly defined"
      end
    end
  end
end
