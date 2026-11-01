# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "a predicate matcher" do
  it "answers to a name that starts with be_" do
    expect(respond_to?(:be_empty)).to be true
  end

  it "answers to a name that starts with have_" do
    expect(respond_to?(:have_key)).to be true
  end

  it "does not answer to another name" do
    expect(respond_to?(:empty)).to be false
  end

  it "does not answer to a name that ends with a question mark" do
    expect(respond_to?(:be_empty?)).to be false
  end

  it "leaves another name undefined" do
    name = begin
      empty
    rescue NameError => e
      e.name
    end
    expect(name).to be :empty
  end
end

# spec/matcher/predicate/name_spec.rb:7: Success: expected true to be true
# spec/matcher/predicate/name_spec.rb:11: Success: expected true to be true
# spec/matcher/predicate/name_spec.rb:15: Success: expected false to be false
# spec/matcher/predicate/name_spec.rb:19: Success: expected false to be false
# spec/matcher/predicate/name_spec.rb:28: Success: expected :empty to be :empty
