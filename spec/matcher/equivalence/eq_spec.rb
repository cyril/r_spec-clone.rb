# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#eq" do
  it { expect("foo").to eq("foo") }
  it { expect("bar").not_to eq("foo") }
end

# spec/matcher/equivalence/eq_spec.rb:6: Success: expected "foo" to eq "foo"
# spec/matcher/equivalence/eq_spec.rb:7: Success: expected "bar" not to eq "foo"
