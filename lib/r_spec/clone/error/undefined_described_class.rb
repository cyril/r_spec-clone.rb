# frozen_string_literal: true

module RSpec
  module Clone
    module Error
      # Exception for undefined described classes.
      class UndefinedDescribedClass < ::RuntimeError
      end
    end
  end
end
