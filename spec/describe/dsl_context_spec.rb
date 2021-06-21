# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Dsl do
  describe ".context" do
    context "when foo is defined" do
      let(:foo) { 42 }

      it "is accessible from the context" do
        expect { foo }.not_to raise_exception NameError
      end
    end

    context "when foo is undefined" do
      it "is not accessible from the context" do
        expect { foo }.to raise_exception NameError
      end
    end
  end
end

# Success: expected 42 not to raise exception NameError.
# Success: undefined local variable or method `foo' for #<#<Class:0x00007feecf1b8558>:0x00007feecf1b8468>.
