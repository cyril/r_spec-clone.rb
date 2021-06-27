# frozen_string_literal: true

require_relative File.join("error", "pending_expectation")
require_relative File.join("error", "reserved_method")
require_relative File.join("error", "undefined_described_class")
require_relative File.join("error", "undefined_subject")

module RSpec
  module Clone
    # Namespace for exceptions.
    #
    # @api private
    module Error
    end
  end
end
