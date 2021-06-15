# frozen_string_literal: true

module RSpec
  module Error
    # Exception for already defined methods.
    #
    # @api private
    class AlreadyDefinedMethod < ::RuntimeError
    end
  end
end
