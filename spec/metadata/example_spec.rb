# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Integer do
  describe 'inner' do
    describe String do
      it "is available as described_class" do
        expect(described_class).to be(String)
      end
    end
  end
end
