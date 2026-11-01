# frozen_string_literal: true

require "r_spec"

RSpec.describe Integer do
  subject { 42 }

  it { is_expected.to be 42 }
  its(:succ) { is_expected.to be 43 }

  pending "is written later"
  pending "is written in another encoding: caf\xE9".b

  context "when divided by zero" do
    its(:/, 0) { is_expected.to raise_exception ZeroDivisionError }
  end

  it "takes several expectations" do
    expect(subject).not_to be_nil
    expect { subject.to_s }.to eq "42"
  end
end

RSpec.it { expect(:done).to be :done }
