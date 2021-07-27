# frozen_string_literal: true

require "rspec/autorun"

# An RSpec spec with 100,000 expectations.
RSpec.describe "true" do
  100_000.times do
    it { expect(true).to be true }
  end
end
