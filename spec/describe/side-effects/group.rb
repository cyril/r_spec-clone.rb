# frozen_string_literal: false

require_relative File.join("..", "..", "spec_helper")

$app2 = "foo"

RSpec.describe "Side effects per group" do
  context "different" do
    before do
      $app2.gsub!("f", "F")
    end

    it { expect($app2).to eq "Foo" }
  end

  it { expect($app2).to eq "foo" }
end

# Success: expected to eq "Foo".
# Success: expected to eq "foo".
