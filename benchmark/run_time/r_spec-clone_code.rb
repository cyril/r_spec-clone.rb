# frozen_string_literal: true

require "r_spec/clone"

# An RSpec clone spec with 100,000 expectations.
RSpec.describe "true" do
  100_000.times do
    it { expect(true).to be true }
  end
end
