# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_nil" do
  it { expect(nil).to be_nil }
  it { expect(:foo).not_to be_nil }
end

# spec/matcher/nil/be_nil_spec.rb:6: Success: expected nil to be nil
# spec/matcher/nil/be_nil_spec.rb:7: Success: expected :foo not to be nil
