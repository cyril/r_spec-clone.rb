# frozen_string_literal: true

require "fix"

# A Fix spec with 1 expectation.
Fix { it MUST be true }.test { true }
