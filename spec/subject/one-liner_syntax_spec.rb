# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Array do
  subject { [1, 2, 3] }

  it { is_expected.to eq([1, 2, 3]) }
end
