# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  context "when the subject is missing" do
    it { is_expected.to raise_exception ::RSpec::Clone::Error::UndefinedSubject }
  end

  context "when the subject is defined" do
    subject { [1, 2, 3] }

    it { is_expected.to eq([1, 2, 3]) }
  end
end

# spec/describe/subject/one_liner_syntax_spec.rb:7: Success: expected #<RSpec::Clone::Error::UndefinedSubject: subject not explicitly defined> to raise exception RSpec::Clone::Error::UndefinedSubject
# spec/describe/subject/one_liner_syntax_spec.rb:13: Success: expected [1, 2, 3] to eq [1, 2, 3]
