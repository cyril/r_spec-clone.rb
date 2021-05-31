# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec do
  subject do
    ::RSpec.describe Integer do
      it { expect(4).to be 42 }
    end
  rescue ::SystemExit => e
    e.success?
  end

  it { is_expected.to be_false }
end
