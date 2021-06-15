# frozen_string_literal: true

require_relative File.join("error", "already_defined_method")
require_relative File.join("error", "pending_expectation")
require_relative File.join("error", "reserved_method")
require_relative File.join("error", "undefined_described_class")
require_relative File.join("error", "undefined_subject")

module RSpec
  # Namespace for exceptions.
  #
  # @api private
  module Error
  end
end
