# frozen_string_literal: true

require "r_spec"

RSpec.describe "nested contexts" do
  context "when the outer one succeeds" do
    context "when the inner one does not" do
      it { expect(4).to be 42 }
    end

    it { expect(:unreached).to be :unreached }
  end
end
