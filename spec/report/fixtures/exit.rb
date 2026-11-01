# frozen_string_literal: true

require "r_spec"

RSpec.describe "exit in a block" do
  pending "is written\non two lines"
  it { expect { exit 3 }.to be_nil }
end
