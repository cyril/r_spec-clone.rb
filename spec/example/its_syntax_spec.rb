# frozen_string_literal: false

require_relative File.join("..", "spec_helper")

RSpec.describe "its syntax" do
  its(:+, 1) { is_expected.to raise_exception ::RSpec::Error::UndefinedSubject }
  its(:length) { is_expected.to raise_exception ::RSpec::Error::UndefinedSubject }
  its(:wow) { pending("feature") }

  context "when defining a subject" do
    subject do
      41
    end

    its(:+, 1) { is_expected.to be 42 }
    its(:length) { is_expected.to raise_exception ::NoMethodError }
    its(:wow) { pending("feature") }

    context "when changing subject" do
      subject do
        "foo"
      end

      its(:+, 1) { is_expected.to raise_exception ::TypeError }
      its(:length) { is_expected.to be 3 }
      its(:wow) { pending("feature") }

      context "when missing subject" do
        its(:+, 1) { is_expected.to raise_exception ::TypeError }
        its(:length) { is_expected.to be 3 }
        its(:wow) { pending("feature") }
      end
    end
  end
end
