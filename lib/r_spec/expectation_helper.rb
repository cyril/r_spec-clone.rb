# frozen_string_literal: true

module RSpec
  # Namespace for `it` and `its` helper modules.
  module ExpectationHelper
  end
end

require_relative File.join("expectation_helper", "it")
require_relative File.join("expectation_helper", "its")
