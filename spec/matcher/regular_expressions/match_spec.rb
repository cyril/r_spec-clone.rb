# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#match" do
  it { expect("bob@example.email").to match(/^[^@]+@[^@]+$/) }
  it { expect("Sydney").not_to match(/^[^@]+@[^@]+$/) }
end

# Success: expected "bob@example.email" to match /^[^@]+@[^@]+$/.
# Success: expected "Sydney" not to match /^[^@]+@[^@]+$/.
