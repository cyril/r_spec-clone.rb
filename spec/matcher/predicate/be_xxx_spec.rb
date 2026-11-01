# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_xxx" do
  it { expect([]).to be_empty }
  it { expect([44]).not_to be_empty }
end

# spec/matcher/predicate/be_xxx_spec.rb:6: Success: expected [] to be empty
# spec/matcher/predicate/be_xxx_spec.rb:7: Success: expected [44] not to be empty
