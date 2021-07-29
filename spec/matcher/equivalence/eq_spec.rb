# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#eq" do
  it { expect("foo").to eq("foo") }
  it { expect("bar").not_to eq("foo") }
end

# Success: expected to eq "foo".
# Success: expected "bar" not to eq "foo".
