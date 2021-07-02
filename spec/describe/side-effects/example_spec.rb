# frozen_string_literal: false

require_relative File.join("..", "..", "spec_helper")

app = "foo"

RSpec.describe "Side effects per example" do
  # :nocov:
  it! "runs the example in isolation" do
    expect { app.gsub!("foo", "bar") }.to eq "bar"
    expect(app).to eq "bar"
  end
  # :nocov:

  it "runs the example" do
    expect(app).to eq "foo"
  end
end

# Success: expected to eq "bar".
# Success: expected to eq "bar".
# Success: expected to eq "foo".
