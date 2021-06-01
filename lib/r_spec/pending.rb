# frozen_string_literal: true

module RSpec
  # Exception raised when an expectation is not implemented.
  #
  # @api private
  #
  # rubocop:disable Lint/InheritException
  class Pending < ::NotImplementedError
  end
  # rubocop:enable Lint/InheritException
end
