# frozen_string_literal: false

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#change" do
  describe "#from" do
    describe "#to" do
      let(:object) do
        @object ||= "foo"
      end

      it "changes object" do
        expect { object.upcase! }.to change(object, :to_s).from("foo").to("FOO")
      end

      it "does not change object" do
        expect { object.upcase }.not_to change(object, :to_s).from("foo").to("FOO")
      end
    end
  end
end

# Success: expected to change from "foo" to "FOO".
# Success: expected not to change from "foo" to "FOO".
