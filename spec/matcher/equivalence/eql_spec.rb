# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#eql" do
  it { expect("foo").to eql("foo") }
  it { expect("bar").not_to eql("foo") }
end

# Success: expected to eq "foo".
# Success: expected "bar" not to eq "foo".
