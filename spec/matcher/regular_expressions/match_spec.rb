# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#match" do
  it { expect("bob@example.email").to match(/^[^@]+@[^@]+$/) }
  it { expect("Sydney").not_to match(/^[^@]+@[^@]+$/) }
end

# spec/matcher/regular_expressions/match_spec.rb:6: Success: expected "bob@example.email" to match /^[^@]+@[^@]+$/
# spec/matcher/regular_expressions/match_spec.rb:7: Success: expected "Sydney" not to match /^[^@]+@[^@]+$/
