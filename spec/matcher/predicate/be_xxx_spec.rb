# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_xxx" do
  it { expect([]).to be_empty }
  it { expect([44]).not_to be_empty }
end

# Success: expected [] to be empty.
# Success: expected [44] not to be empty.
