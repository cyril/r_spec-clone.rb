# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".its" do
    its(:+, 1) { is_expected.to raise_exception ::RSpec::Clone::Error::UndefinedSubject }
    its(:length) { is_expected.to raise_exception ::RSpec::Clone::Error::UndefinedSubject }

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

# Success: subject not explicitly defined.
# Success: subject not explicitly defined.
# Success: expected to be 42.
# Success: undefined method `length' for 41:Integer.
# Success: no implicit conversion of Integer into String.
# Success: expected to be 3.
# Success: no implicit conversion of Integer into String.
# Success: expected to be 3.
