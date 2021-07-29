# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_nil" do
  it { expect(nil).to be_nil }
  it { expect(:foo).not_to be_nil }
end

# Success: expected to be nil.
# Success: expected :foo not to be nil.
