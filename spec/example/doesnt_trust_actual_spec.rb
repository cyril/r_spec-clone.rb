# frozen_string_literal: false

require_relative File.join("..", "spec_helper")

APP = "💩"

def APP.equal?(*) true end

RSpec.describe APP.class do
  it { expect(described_class).not_to be "🌈" }
end
