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

# spec/describe/dsl_its_spec.rb:7: Success: expected #<RSpec::Clone::Error::UndefinedSubject: subject not explicitly defined> to raise exception RSpec::Clone::Error::UndefinedSubject
# spec/describe/dsl_its_spec.rb:8: Success: expected #<RSpec::Clone::Error::UndefinedSubject: subject not explicitly defined> to raise exception RSpec::Clone::Error::UndefinedSubject
# spec/describe/dsl_its_spec.rb:15: Success: expected 42 to be 42
# spec/describe/dsl_its_spec.rb:16: Success: expected #<NoMethodError: undefined method 'length' for an instance of Integer> to raise exception NoMethodError
# spec/describe/dsl_its_spec.rb:23: Success: expected #<TypeError: no implicit conversion of Integer into String> to raise exception TypeError
# spec/describe/dsl_its_spec.rb:24: Success: expected 3 to be 3
# spec/describe/dsl_its_spec.rb:27: Success: expected #<TypeError: no implicit conversion of Integer into String> to raise exception TypeError
# spec/describe/dsl_its_spec.rb:28: Success: expected 3 to be 3
