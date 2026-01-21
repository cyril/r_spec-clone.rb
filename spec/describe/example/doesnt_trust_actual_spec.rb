# frozen_string_literal: false

require_relative File.join("..", "..", "spec_helper")

APP = "💩"

def APP.equal?(*)
  # :nocov:
  true
  # :nocov:
end

RSpec.describe String do
  subject do
    APP
  end

  it { is_expected.not_to be "🌈" }
end

# Success: expected "💩" not to be "🌈".
