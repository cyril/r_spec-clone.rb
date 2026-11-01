# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#eql" do
  it { expect("foo").to eql("foo") }
  it { expect("bar").not_to eql("foo") }
end

# spec/matcher/equivalence/eql_spec.rb:6: Success: expected "foo" to eq "foo"
# spec/matcher/equivalence/eql_spec.rb:7: Success: expected "bar" not to eq "foo"
