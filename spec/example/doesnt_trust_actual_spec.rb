# frozen_string_literal: false

require_relative File.join("..", "spec_helper")

# rubocop:disable Style/MutableConstant
APP = "💩"
# rubocop:enable Style/MutableConstant

RSpec.describe String do
  subject do
    APP
  end

  before do
    def APP.equal?(*)
      true
    end
  end

  it { expect(APP).not_to be "🌈" }
end
