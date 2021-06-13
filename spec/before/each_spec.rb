# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Array do
  before do
    $number = 0
  end

  it { expect($number).to be(0) }

  context "when adding 1" do
    before do
      $number += 1
    end

    it { expect($number).to be(1) }
  end

  it { expect($number).to be(0) }
end
