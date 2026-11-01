# frozen_string_literal: true

require "r_spec"

RSpec.describe "a context" do
  context "when it fails" do
    it { expect(4).to be 42 }
  end

  it { expect(:unreached).to be :unreached }
end
