# frozen_string_literal: true

require_relative File.join "support", "coverage"
require_relative File.join "..", "lib", "r_spec"
require "spectus"

include Spectus

begin
  RSpec.describe Integer do
    it "is available as described_class" do
      expect(described_class).to eq(Integer)
    end
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end

begin
  RSpec.describe Integer do
    describe String do
      it "is available as described_class" do
        expect(described_class).to eq(String)
      end
    end
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end

begin
  RSpec.describe Integer do
    describe "foo" do
      it "is available as described_class" do
        expect(described_class).to eq(String)
      end
    end
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end
