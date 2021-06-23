# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.context "when divided by zero" do
  subject { 42 / 0 }

  it { is_expected.to raise_exception ZeroDivisionError }
end

# Success: divided by 0.
