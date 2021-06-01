# frozen_string_literal: true

require_relative File.join("r_spec", "dsl")

# Main namespace.
#
# @example
#   require "r_spec"
#
#   RSpec.describe Integer do
#     it { expect(41.next).to be 42 }
#   end
#
# @api public
module RSpec
  # Specs are built with this method.
  #
  # @param const [Module] module to include in block context
  # @param block [Proc] the block to define the specs
  #
  # @api public
  def self.describe(const, &block)
    raise ::TypeError, const.class.inspect unless const.is_a?(::Module)

    DSL.describe(const, &block)
  end
end
