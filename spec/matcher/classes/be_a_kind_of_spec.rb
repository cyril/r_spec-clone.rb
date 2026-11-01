# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_a_kind_of" do
  it { expect(42).to be_a_kind_of(Comparable) }
  it { expect(:foo).not_to be_a_kind_of(Numeric) }
end

# spec/matcher/classes/be_a_kind_of_spec.rb:6: Success: expected 42 to be a kind of Comparable
# spec/matcher/classes/be_a_kind_of_spec.rb:7: Success: expected :foo not to be a kind of Numeric
