# frozen_string_literal: true

module RSpec
  module Error
    # Exception for reserved methods.
    #
    # @api private
    class ReservedMethod < ::RuntimeError
    end
  end
end
