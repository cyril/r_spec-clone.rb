# frozen_string_literal: true

require "matchi/rspec"
require "securerandom"

module RSpec
  class DSL
    include ::Matchi::Helper

    def self.before(&block)
      define_method(:initialize) do |*args, **kwargs|
        super()
        instance_exec(*args, **kwargs, &block)
      end
    end

    def self.describe(const = nil, &block)
      class_name = "Test#{::SecureRandom.alphanumeric(10)}"
      klass = Test.const_set(class_name, ::Class.new(self))

      if const.is_a?(::Module)
        klass.define_method(:described_class) do
          klass.const_get(const.to_s)
        end

        klass.send(:protected, :described_class)
      end

      klass.instance_eval(&block)
      klass
    end

    def self.it(description = "test_#{::SecureRandom.hex(8)}", &block)
      define_method(description.to_sym) do |*args, **kwargs|
        it_class = ::Class.new(self) # { include ::Matchi::Helper }

        # it_class.define_method(:expect) do |actual|
        #   Expect.new(actual)
        # end

        if block
          result = it_class.instance_exec(*args, **kwargs, &block)
          print block.source_location.join(":"), " " if result.failed?
          result
        else
          ::Expresenter.call(true).new(
            actual:   ::NotImplementedError.new(description),
            error:    nil,
            expected: ::NotImplementedError,
            got:      false,
            matcher:  :raise_exception,
            negate:   true,
            level:    :SHOULD,
            valid:    false
          )
        end
      end
    end

    def self.let(identifier, &block)
      protected define_method(identifier, &block)
    end

    def self.subject(&block)
      let(__method__, &block)
    end

    protected

    def subject
      described_class
    end

    private

    def expect(actual)
      Expect.new(actual)
    end

    # rubocop:disable Naming/PredicateName
    def is_expected
      expect(@subject)
    end
    # rubocop:enable Naming/PredicateName
  end
end

require_relative "expect"
require_relative "test"
