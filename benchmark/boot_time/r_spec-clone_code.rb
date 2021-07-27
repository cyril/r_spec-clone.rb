# frozen_string_literal: true

require "r_spec/clone"

# An RSpec clone spec with 1 expectation.
RSpec.describe "true" do
  it { expect(true).to be true }
end
