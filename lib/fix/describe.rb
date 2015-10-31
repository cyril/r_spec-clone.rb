# Namespace for the Fix framework.
module Fix
  # Override Fix's On class.
  class On
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
  end
end
