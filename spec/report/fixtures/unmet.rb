# frozen_string_literal: true

require "r_spec"

RSpec.describe Integer do
  it { expect(4).to be 4 }
  it { expect(4).to be 42 }
  it { expect(:unreached).to be :unreached }
end
