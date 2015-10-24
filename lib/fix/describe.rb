# Namespace for the Fix framework.
module Fix
  # Override Fix's On class.
  class On
    # @param another_front_object [BasicObject] The front object.
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
