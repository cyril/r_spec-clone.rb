# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#equal" do
  it { expect(:foo).to equal(:foo) }
  it { expect(:bar).not_to equal(:foo) }
end

# spec/matcher/identity/equal_spec.rb:6: Success: expected :foo to be :foo
# spec/matcher/identity/equal_spec.rb:7: Success: expected :bar not to be :foo
