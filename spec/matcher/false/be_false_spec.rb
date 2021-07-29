# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_false" do
  it { expect(false).to be_false }
  it { expect(true).not_to be_false }
end

# Success: expected to be false.
# Success: expected true not to be false.
