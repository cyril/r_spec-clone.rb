# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#satisfy" do
  it { expect { 42 }.to satisfy { |value| value == 42 } }
  it { expect { 44 }.not_to satisfy { |value| value == 42 } }
end

# Success: expected 42 to satisfy &block.
# Success: expected 44 not to satisfy &block.
