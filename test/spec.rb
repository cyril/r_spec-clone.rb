# frozen_string_literal: true

require "simplecov"
SimpleCov.command_name "RSpec clone"
SimpleCov.start

require_relative File.join("..", "lib", "r_spec")

## Described class

RSpec.describe Baz do
  it { expect(described_class).to be Baz }

  describe :foo do
    it { expect(described_class).to be Baz }
  end

  describe Foo do
    it { expect(described_class).to be Foo }

    describe Foo::Fooo do
      describe Foo do
        it { expect(described_class).to be Foo }
      end
    end
  end
end

RSpec.describe do
  it "is not implemented"

  it "is the default described_class" do
    expect(described_class).to be ::Object
  end
end

## Subject

RSpec.describe do
  let(:value) { "#{subject.name}42" }
  it { expect(subject).to be Object }
  it { expect(value).to eq "Object42" }
end
