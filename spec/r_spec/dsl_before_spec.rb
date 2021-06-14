# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

# rubocop:disable RSpec/InstanceVariable
RSpec.describe RSpec::Dsl do
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
# rubocop:enable RSpec/InstanceVariable
