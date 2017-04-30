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
    def before(*)
      yield
    end

    # @param another_front_object [#object_id]  Override the front object.
    # @param specs                [Proc]        A set of specs.
    #
    # @return [Array] List of results.
    def describe(another_front_object, *, &specs)
      o = On.new(another_front_object,
                 results,
                 challenges,
                 helpers.dup,
                 configuration)

      o.instance_eval(&specs)
    end

    # Override the implicit subject.
    #
    # @param block [Proc, nil] Another subject inside a block.
    #
    # @return [#object_id] The subject.
    def subject(&block)
      if block_given?
        @described = yield
      else
        super
      end
    end
  end
end
