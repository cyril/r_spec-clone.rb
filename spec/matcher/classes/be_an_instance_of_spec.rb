# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_an_instance_of" do
  it { expect(42).to be_an_instance_of(Integer) }
  it { expect(:foo).not_to be_an_instance_of(Integer) }
end

# Success: expected 42 to be an instance of Integer.
# Success: expected :foo not to be an instance of Integer.
