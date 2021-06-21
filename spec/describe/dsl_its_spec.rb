# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Dsl do
  describe ".its" do
    its(:+, 1) { is_expected.to raise_exception ::RSpec::Error::UndefinedSubject }
    its(:length) { is_expected.to raise_exception ::RSpec::Error::UndefinedSubject }

    context "when a subject is defined" do
      subject do
        41
      end

      its(:+, 1) { is_expected.to be 42 }
      its(:length) { is_expected.to raise_exception ::NoMethodError }

      context "when another subject is defined" do
        subject do
          "foo"
        end

        its(:+, 1) { is_expected.to raise_exception ::TypeError }
        its(:length) { is_expected.to be 3 }

        context "when no other subject is defined" do
          its(:+, 1) { is_expected.to raise_exception ::TypeError }
          its(:length) { is_expected.to be 3 }
        end
      end
    end
  end
end
