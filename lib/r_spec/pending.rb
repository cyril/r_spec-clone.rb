# frozen_string_literal: true

module RSpec
  # Exception raised when an expectation is not implemented.
  #
  # rubocop:disable Lint/InheritException
  class Pending < ::NotImplementedError; end
  # rubocop:enable Lint/InheritException
end
