# frozen_string_literal: true

require "matchi/rspec"
require "securerandom"

module RSpec
  # Abstract class for handling the domain-specific language.
  class DSL
    # @param block [Proc] The content to execute at the class initialization.
    def self.before(&block)
      define_method(:initialize) do |*args, **kwargs|
        super()
        instance_exec(*args, **kwargs, &block)
      end
    end

    # @param block [Proc] The content of the method to define.
    # @return [Symbol] A protected method that define the block content.
    def self.let(name, &block)
      protected define_method(name.to_sym, &block)
    end

    # @param block [Proc] The subject to set.
    # @return [Symbol] A `subject` method that define the block content.
    def self.subject(&block)
      let(__method__, &block)
    end

    # Describe a set of expectations.
    #
    # @param const [Module, #object_id] A module to include in block context.
    # @param block [Proc] The block to define the specs.
    def self.describe(const, &block)
      root = const_set("Test", ::Module.new)
      desc = root.const_set("Test#{random_str}", ::Class.new(self))

      if const.is_a?(::Module)
        desc.define_method(:described_class) { const }
        desc.send(:protected, :described_class)
      end

      desc.instance_eval(&block)
      desc
    end

    singleton_class.send(:alias_method, :context, :describe)

    # Evaluate an expectation.
    #
    # @param block [Proc] An expectation to evaluate.
    #
    # @raise (see ExpectationTarget#result)
    # @return (see ExpectationTarget#result)
    def self.it(_name = nil, &block)
      raise ::ArgumentError, "Missing block for #{name.inspect} test" unless block

      path_info = block.source_location.join(":")
      print "\e[3m#{path_info}\e[23m "

      i = example.new
      i.instance_eval(&block)
    end

    # @private
    #
    # @return [Class<DSL>] The class of the example to be tested.
    private_class_method def self.example
      ::Class.new(self) do
        include ::Matchi::Helper

        private

        # Wraps the target of an expectation with the actual value.
        #
        # @param actual [#object_id] The actual value.
        #
        # @return [ExpectationTarget] The target of the expectation.
        def expect(actual)
          undef expect
          undef is_expected
          undef pending

          ExpectationTarget.new(actual)
        end

        # Wraps the target of an expectation with the subject as actual value.
        #
        # @return [ExpectationTarget] (see #expect)
        def is_expected
          expect(subject)
        end

        def pending(description)
          undef expect
          undef is_expected
          undef pending

          Pending.result(description)
        end
      end
    end

    # @private
    #
    # @return [String] A random string.
    private_class_method def self.random_str
      ::SecureRandom.alphanumeric(5)
    end
  end
end

require_relative "expectation_target"
require_relative "pending"
