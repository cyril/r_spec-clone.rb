# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be" do
  it { expect(:foo).to be(:foo) }
  it { expect(:bar).not_to be(:foo) }
end

# spec/matcher/identity/be_spec.rb:6: Success: expected :foo to be :foo
# spec/matcher/identity/be_spec.rb:7: Success: expected :bar not to be :foo
