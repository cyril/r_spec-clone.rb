# frozen_string_literal: true

require_relative File.join("expectation_helper", "it")
require_relative File.join("expectation_helper", "matcher")

module RSpec
  module Clone
    # The words an example can use, prepended to its class: {It} by
    # {Dsl.it}, {Matcher} by {Dsl.its}, which adds `is_expected` itself.
    module ExpectationHelper
    end
  end
end
