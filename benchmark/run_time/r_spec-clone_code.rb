# frozen_string_literal: true

require "r_spec/clone"

# An RSpec clone spec with 10 000 expectations.
RSpec.describe "The true from the false" do
  10_000.times do
    it { expect(false).not_to be(true) }
  end
end
