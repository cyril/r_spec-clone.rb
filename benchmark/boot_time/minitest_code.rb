# frozen_string_literal: true

require "minitest/autorun"

# A minitest spec with 1 expectation.
class Test < Minitest::Test
  def test_method
    refute_equal(true, false)
  end
end
