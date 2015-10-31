# Namespace for the Fix framework.
module Fix
  # Override Fix's It class.
  class It
    # @return [Class] The class of the described object.
    def described_class
      subject.is_a?(::Class) ? subject : subject.class
    end
  end
end
