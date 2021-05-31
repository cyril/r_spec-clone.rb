# frozen_string_literal: false

require_relative File.join("..", "spec_helper")

$app = "💩"
def $app.equal?(*) true; end

RSpec.describe String do
  it { expect($app).not_to be "🌈" }
end
