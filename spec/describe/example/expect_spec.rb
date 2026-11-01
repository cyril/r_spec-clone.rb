# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#expect" do
  it "takes a value" do
    expect(expect(4).class).to be RSpec::Clone::ExpectationTarget
  end

  it "takes a block" do
    expect(expect { 4 }.class).to be RSpec::Clone::ExpectationTarget
  end

  it "takes a value or a block, not both" do
    expect { expect(4) { 4 } }.to raise_exception ArgumentError
  end

  it "takes a value or a block, not neither" do
    expect { expect }.to raise_exception ArgumentError
  end

  it "takes one value" do
    expect { expect(4, 4) }.to raise_exception ArgumentError
  end
end

# spec/describe/example/expect_spec.rb:7: Success: expected RSpec::Clone::ExpectationTarget to be RSpec::Clone::ExpectationTarget
# spec/describe/example/expect_spec.rb:11: Success: expected RSpec::Clone::ExpectationTarget to be RSpec::Clone::ExpectationTarget
# spec/describe/example/expect_spec.rb:15: Success: expected #<ArgumentError: expect takes one value or a block> to raise exception ArgumentError
# spec/describe/example/expect_spec.rb:19: Success: expected #<ArgumentError: expect takes one value or a block> to raise exception ArgumentError
# spec/describe/example/expect_spec.rb:23: Success: expected #<ArgumentError: expect takes one value or a block> to raise exception ArgumentError
