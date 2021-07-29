# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#have_xxx" do
  it { expect(foo: 42).to have_key(:foo) }
  it { expect(bar: 42).not_to have_key(:foo) }
end

# Success: expected {:foo=>42} to have key :foo.
# Success: expected {:bar=>42} not to have key :foo.
