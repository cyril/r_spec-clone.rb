# frozen_string_literal: true

require "fix"

# A Fix spec with 1 expectation.
Fix { it MUST_NOT equal true }.test { false }
