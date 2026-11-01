# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".before" do
    before do
      @number = 0
    end

    context "when adding 1" do
      before do
        @number += 1
      end

      it { expect(@number).to be(1) }
    end

    it { expect(@number).to be(0) }
  end
end

# spec/describe/dsl_before_spec.rb:16: Success: expected 1 to be 1
# spec/describe/dsl_before_spec.rb:19: Success: expected 0 to be 0
