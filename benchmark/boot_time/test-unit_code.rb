# frozen_string_literal: true

require "test/unit"

# A test-unit spec with 1 expectation.
class TestMethod < Test::Unit::TestCase
  def test_method
    refute_equal(false, true)
  end
end
