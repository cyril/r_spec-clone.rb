# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_false" do
  it { expect(false).to be_false }
  it { expect(true).not_to be_false }
end

# spec/matcher/false/be_false_spec.rb:6: Success: expected false to be false
# spec/matcher/false/be_false_spec.rb:7: Success: expected true not to be false
