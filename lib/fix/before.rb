# Namespace for the Fix framework.
module Fix
  # Override Fix's On class.
  class On
    # Useful to perform side-effects, e.g., add something in to a database.
    #
    # @note To declare an instance variable, use the `let` helper instead.
    #
    # @param block [Proc] The block to call.
    #
    # @return [#object_id] The given block.
    def before(*, &block)
      block.call
    end
  end
end
