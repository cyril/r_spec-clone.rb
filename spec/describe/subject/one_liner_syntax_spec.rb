# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  context "when the subject is missing" do
    it { is_expected.to raise_exception ::RSpec::Error::UndefinedSubject }
  end

  context "when the subject is defined" do
    subject { [1, 2, 3] }

    it { is_expected.to eq([1, 2, 3]) }
  end
end
