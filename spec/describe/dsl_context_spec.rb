# frozen_string_literal: false

require_relative File.join("..", "spec_helper")

app = "Hello, world!"

RSpec.describe String do
  # :nocov:
  subject do
    app
  end

  before do
    subject.gsub!("world", person)
  end

  context! "when Alice is greeted" do
    let(:person) { "Alice" }

    it { is_expected.to eq "Hello, Alice!" }
  end

  context! "when Bob is greeted" do
    let(:person) { "Bob" }

    it { is_expected.to eq "Hello, Bob!" }
  end
  # :nocov:
end

# Success: expected to eq "Hello, Alice!".
# Success: expected to eq "Hello, Bob!".
