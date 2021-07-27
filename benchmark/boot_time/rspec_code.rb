# frozen_string_literal: true

require "rspec/autorun"

# An RSpec spec with 1 expectation.
RSpec.describe "true" do
  it { expect(true).to be true }
end
