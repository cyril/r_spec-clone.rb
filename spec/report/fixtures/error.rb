# frozen_string_literal: true

require "r_spec"

RSpec.describe "an exception" do
  it { expect { raise "boom\nbang" }.to be_nil }
end
