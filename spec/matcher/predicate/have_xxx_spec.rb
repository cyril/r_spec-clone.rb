# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#have_xxx" do
  it { expect(foo: 42).to have_key(:foo) }
  it { expect(bar: 42).not_to have_key(:foo) }
end

# spec/matcher/predicate/have_xxx_spec.rb:6: Success: expected {foo: 42} to have key :foo
# spec/matcher/predicate/have_xxx_spec.rb:7: Success: expected {bar: 42} not to have key :foo
