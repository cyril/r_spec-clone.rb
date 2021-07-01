# frozen_string_literal: false

require_relative File.join("..", "..", "spec_helper")

$app = "foo"

RSpec.describe "Scoped side effects" do
  describe! "#gsub!" do
    before do
      $app.gsub!("o", "0")
    end

    context! "when limited to the context" do
      before do
        $app.gsub!("f", "F")
      end

      it { expect($app).to eq "F00" }
    end

    it { expect($app).to eq "f00" }
  end

  it { expect($app).to eq "foo" }
end

# Success: expected to eq "F00".
# Success: expected to eq "f00".
# Success: expected to eq "foo".
