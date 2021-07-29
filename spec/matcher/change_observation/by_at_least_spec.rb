# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#change" do
  describe "#by_at_least" do
    let(:object) do
      @object ||= []
    end

    it "changes object" do
      expect { object << 1 }.to change(object, :length).by_at_least(1)
    end

    it "does not change object" do
      expect { object }.not_to change(object, :length).by_at_least(1)
    end
  end
end

# Success: expected [1] to change by at least 1.
# Success: expected [] not to change by at least 1.
