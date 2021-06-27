# frozen_string_literal: true

module RSpec
  module Clone
    module Error
      # Exception for undefined subjects.
      #
      # @api private
      class UndefinedSubject < ::RuntimeError
      end
    end
  end
end
