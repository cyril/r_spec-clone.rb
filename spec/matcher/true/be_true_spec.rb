# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_true" do
  it { expect(true).to be_true }
  it { expect(false).not_to be_true }
end

# spec/matcher/true/be_true_spec.rb:6: Success: expected true to be true
# spec/matcher/true/be_true_spec.rb:7: Success: expected false not to be true
