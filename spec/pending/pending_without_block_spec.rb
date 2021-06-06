# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Dsl do
  it "is implemented but waiting" do
    pending("something else getting finished")
  end
end
