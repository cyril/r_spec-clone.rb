# frozen_string_literal: true

module RSpec
  module Clone
    module Error
      # Exception for reserved methods.
      class ReservedMethod < ::RuntimeError
      end
    end
  end
end
