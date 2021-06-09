# frozen_string_literal: true

module RSpec
  # Namespace for exceptions.
  #
  # @api private
  module Error
  end
end

require_relative File.join("error", "pending_expectation")
require_relative File.join("error", "undefined_described_class")
require_relative File.join("error", "undefined_subject")
