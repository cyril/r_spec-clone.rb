# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#equal" do
  it { expect(:foo).to equal(:foo) }
  it { expect(:bar).not_to equal(:foo) }
end

# Success: expected to be :foo.
# Success: expected :bar not to be :foo.
