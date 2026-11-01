# frozen_string_literal: false

require_relative File.join("..", "spec_helper")

app = "Hello, world!"

RSpec.describe String do
  subject do
    app
  end

  before do
    subject.gsub!("world", person)
  end

  context "when Alice is greeted" do
    let(:person) { "Alice" }

    it { is_expected.to eq "Hello, Alice!" }
  end

  context "when Bob is greeted" do
    let(:person) { "Bob" }

    it { is_expected.to eq "Hello, Bob!" }
  end
end

# spec/describe/dsl_context_spec.rb:19: Success: expected "Hello, Alice!" to eq "Hello, Alice!"
# spec/describe/dsl_context_spec.rb:25: Success: expected "Hello, Bob!" to eq "Hello, Bob!"
