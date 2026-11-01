# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "a block that forks" do
  it "lets the child leave without a word" do
    expect { Process.wait(fork { nil }); :parent }.to be :parent
  end

  it "does not let a child that runs on write" do
    expect { fork ? :parent : :child }.to be :parent
  end
end

# spec/describe/example/fork_spec.rb:7: Success: expected :parent to be :parent
# spec/describe/example/fork_spec.rb:11: Success: expected :parent to be :parent
