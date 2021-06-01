# frozen_string_literal: true

require "expresenter"
require "matchi/rspec"
require "securerandom"

module RSpec
  # Abstract class for handling the domain-specific language.
  #
  # @api private
  class DSL
    def self.before(&block)
      define_method(:initialize) do |*args, **kwargs|
        super()
        instance_exec(*args, **kwargs, &block)
      end
    end

    def self.let(name, &block)
      protected define_method(name.to_sym, &block)
    end

    def self.subject(&block)
      let(__method__, &block)
    end

    def self.describe(const, &block)
      desc = Test.const_set("Test#{random_str}", ::Class.new(self))

      if const.is_a?(::Module)
        desc.define_method(:described_class) { const }
        desc.send(:protected, :described_class)
      end

      desc.instance_eval(&block)
      desc
    end

    singleton_class.send(:alias_method, :context, :describe)

    def self.it(name = "test_#{random_str.downcase}", &block)
      raise ::ArgumentError, "Missing block for #{name.inspect} test" unless block

      path_info = block.source_location.join(":")
      print "\e[3m#{path_info}\e[23m "

      i = example.new
      i.instance_eval(&block)
    end

    private_class_method def self.example
      ::Class.new(self) do
        include ::Matchi::Helper

        private

        def expect(actual)
          undef expect
          undef is_expected
          undef pending

          Expect.new(actual)
        end

        # rubocop:disable Naming/PredicateName
        def is_expected
          expect(subject)
        end
        # rubocop:enable Naming/PredicateName

        def pending(description)
          undef expect
          undef is_expected
          undef pending

          puts Requirement.pending(description).colored_string
        end
      end
    end

    private_class_method def self.random_str
      ::SecureRandom.alphanumeric(5)
    end
  end
end

require_relative "expect"
require_relative "test"
