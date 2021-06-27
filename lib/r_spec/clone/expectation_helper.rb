# frozen_string_literal: true

require_relative File.join("expectation_helper", "it")
require_relative File.join("expectation_helper", "its")

module RSpec
  module Clone
    # Namespace for {Dsl.it} and {Dsl.its}'s helper modules.
    module ExpectationHelper
    end
  end
end
