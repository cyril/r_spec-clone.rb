# frozen_string_literal: true

require_relative "shared"
require_relative File.join("..", "expectation_target")

module RSpec
  module Clone
    module ExpectationHelper
      # {RSpec::Clone::Dsl.it}'s expectation helper module.
      module It
        include Shared

        # Create an expectation for a spec.
        #
        # @param value [#object_id, nil]  An actual value.
        # @param block [#call, nil]       A code to evaluate.
        #
        # @return [Block, Value] The wrapped target of an expectation.
        #
        # @example
        #   expect("foo") # => #<RSpec::Clone::ExpectationTarget::Value:0x00007f @actual="foo">
        #   expect { Boom } # => #<RSpec::Clone::ExpectationTarget::Block:0x00007f @callable=#<Proc:0x00007f>>
        #
        # @api public
        def expect(value = self.class.superclass, &block)
          ExpectationTarget.call(self.class.superclass, value, block)
        end

        # Wraps the target of an expectation with the subject as actual value.
        #
        # @return [Block] The wrapped target of an expectation.
        #
        # @example
        #   is_expected # => #<RSpec::Clone::ExpectationTarget::Block:0x00007fb6b8 @callable=#<Proc:0x00007fb6b8>>
        #
        # @api public
        def is_expected
          expect { subject }
        end
      end
    end
  end
end
