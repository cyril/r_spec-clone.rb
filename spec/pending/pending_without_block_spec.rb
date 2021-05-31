# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::DSL do
  it "is implemented but waiting" do
    pending("something else getting finished")
  end
end
