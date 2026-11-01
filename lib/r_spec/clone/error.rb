# frozen_string_literal: true

module RSpec
  module Clone
    # The errors of the clone, raised where a spec asks for what it did not
    # define.
    module Error
      # Raised by `let` for a name the clone keeps for itself.
      class ReservedMethod < ::RuntimeError
      end

      # Raised by `described_class` when no enclosing `describe` names a
      # module.
      class UndefinedDescribedClass < ::RuntimeError
      end

      # Raised by `subject` when no enclosing group defines one.
      class UndefinedSubject < ::RuntimeError
      end
    end
  end
end
