# frozen_string_literal: true

require_relative File.join("..", "spec_helper")
require "tempfile"

RSpec.describe Tempfile do
  subject do
    @file
  end

  before do
    @file = described_class.new("test after syntax")
  end

  after do
    @file.close
    @file.unlink
  end

  its(:read) { is_expected.to eq "" }

  context "when some content is added to the file" do
    before do
      @file.write("hello world")
      @file.rewind
    end

    its(:read) { is_expected.to eq "hello world" }
  end

  its(:read) { is_expected.to eq "" }
end
