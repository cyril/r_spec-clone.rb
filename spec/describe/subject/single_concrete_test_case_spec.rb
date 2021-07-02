# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  subject { [1, 2, 3] }

  its(:size) { is_expected.to be 3 }
  its(:downcase) { is_expected.to raise_exception NoMethodError }
end

# Success: expected to be 3.
# Success: undefined method `downcase' for [1, 2, 3]:Array.
