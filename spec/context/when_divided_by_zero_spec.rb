# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.context "when divided by zero" do
  subject { 42 / 0 }

  it { is_expected.to raise_exception ZeroDivisionError }
end

# spec/context/when_divided_by_zero_spec.rb:8: Success: expected #<ZeroDivisionError: divided by 0> to raise exception ZeroDivisionError
