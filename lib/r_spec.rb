# frozen_string_literal: true

# Namespace for the RSpec framework.
#
# @api public
#
module RSpec
  # Specs are built with this method.
  def self.describe(const, &block)
    raise ::TypeError, const.class.inspect unless const.is_a?(::Module)

    DSL.describe(const, &block)
  end
end

require_relative File.join("r_spec", "dsl")
