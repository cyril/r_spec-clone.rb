# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  subject { [1, 2, 3] }

  its(:size) { is_expected.to be 3 }
  its(:downcase) { is_expected.to raise_exception NoMethodError }
end

# spec/describe/subject/single_concrete_test_case_spec.rb:8: Success: expected 3 to be 3
# spec/describe/subject/single_concrete_test_case_spec.rb:9: Success: expected #<NoMethodError: undefined method 'downcase' for an instance of Array> to raise exception NoMethodError
