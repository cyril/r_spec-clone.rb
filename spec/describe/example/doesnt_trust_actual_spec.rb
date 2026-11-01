# frozen_string_literal: false

require_relative File.join("..", "..", "spec_helper")

APP = "💩"

def APP.equal?(*)
  true
end

RSpec.describe String do
  subject do
    APP
  end

  it { is_expected.not_to be "🌈" }
end

# spec/describe/example/doesnt_trust_actual_spec.rb:16: Success: expected "💩" not to be "🌈"
