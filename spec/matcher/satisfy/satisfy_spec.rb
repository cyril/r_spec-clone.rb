# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#satisfy" do
  it { expect { 42 }.to satisfy { |value| value == 42 } }
  it { expect { 44 }.not_to satisfy { |value| value == 42 } }
end

# spec/matcher/satisfy/satisfy_spec.rb:6: Success: expected 42 to satisfy &block
# spec/matcher/satisfy/satisfy_spec.rb:7: Success: expected 44 not to satisfy &block
