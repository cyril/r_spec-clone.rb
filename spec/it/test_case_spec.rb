# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.it "compares true and false" do
  expect(false).not_to be_true
end
