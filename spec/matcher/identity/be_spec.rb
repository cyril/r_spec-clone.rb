# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be" do
  it { expect(:foo).to be(:foo) }
  it { expect(:bar).not_to be(:foo) }
end

# Success: expected to be :foo.
# Success: expected :bar not to be :foo.
