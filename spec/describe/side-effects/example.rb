# frozen_string_literal: false

require_relative File.join("..", "..", "spec_helper")

app = "foo"

RSpec.describe "Side effects per example" do
  it "shares a common environment" do
    expect { app.gsub!("foo", "bar") }.to eq "bar"
    expect(app).to eq "bar"
  end

  it "instanciates a new environment" do
    expect(app).to eq "foo"
  end
end

# Success: expected to eq "bar".
# Success: expected to eq "foo".
# Success: expected to eq "bar".
