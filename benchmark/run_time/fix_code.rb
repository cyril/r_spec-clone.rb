# frozen_string_literal: true

require "fix"

# A Fix spec with 1,000,000 expectations.
specs = Fix do
  1_000_000.times do
    it MUST_NOT equal true
  end
end

specs.test { false }
