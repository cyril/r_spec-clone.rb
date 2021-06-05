# frozen_string_literal: true

# Top level namespace for the RSpec clone.
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
  # @param const [Module, String] A module to include in block context.
  # @param block [Proc] The block to define the specs.
  #
  # @api public
  def self.describe(const, &block)
    DSL.describe(const, &block)
  end
end

require_relative File.join("r_spec", "dsl")
