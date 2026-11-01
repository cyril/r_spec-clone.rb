# frozen_string_literal: true

require "r_spec"

RSpec.describe "exit outside an expectation" do
  it { expect(4).to be 4 }
  it { exit 3 }
  it { expect(:unreached).to be :unreached }
end
