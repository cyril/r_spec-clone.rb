# frozen_string_literal: true

module RSpec
  module Error
    # Exception for undefined subjects.
    #
    # @api private
    class UndefinedSubject < ::RuntimeError
    end
  end
end
