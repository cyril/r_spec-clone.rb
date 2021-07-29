# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#change" do
  describe "#by_at_most" do
    let(:object) do
      @object ||= []
    end

    it "changes object" do
      expect { object << 1 }.to change(object, :length).by_at_most(1)
    end

    it "does not change object" do
      expect { object << 1 << 2 }.not_to change(object, :length).by_at_most(1)
    end
  end
end

# Success: expected [1] to change by at most 1.
# Success: expected [1, 2] not to change by at most 1.
