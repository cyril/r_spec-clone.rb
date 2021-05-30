# frozen_string_literal: true

require_relative File.join("test", "app")

require "simplecov"
SimpleCov.command_name "RSpec clone"
SimpleCov.start

require_relative File.join("lib", "r_spec")

RSpec.describe Foo do
  let(:var1) { "var 1" }

  describe "#foo" do
    it { expect(described_class).to eq Foo }
    it { expect(described_class.new.foo).to eq 42 }
  end

  context "when foo bar baz" do
    it { expect(described_class).to eq Foo }
    it { expect(described_class.new.foo).to eq 42 }
  end

  subject do
    var1
  end

  it { is_expected.to eq "var 1" }

  it "works" do
    # puts "it works well!!!!"
    # puts "public methods: #{public_methods.inspect}"
    # puts "private methods: #{private_methods.inspect}"
    # puts "protected methods: #{protected_methods.inspect}"
    # puts "BTW here is inside #{self.inspect} (#{self.class})"
    # puts "described_class is: #{described_class.inspect}"
    # puts "INFO: var1 is equal to: #{var1.inspect}"

    expect(42).to be 42
    # puts expect(42).to be 4
  end

  # it { expect(44).to be 4 }

  it "wont_work" do
    # it "work_not" do
    #  puts 4
    # end

    pending("99999")
  end

  before do
    # puts "before... var1: #{var1.inspect}"
  end

  describe Foo::Fooo do
    before do
      puts "before 3..."
      puts "described_class is: #{described_class.inspect}"
      puts "var1 is now: #{var1.inspect}"
    end

    let(:var1) { 44_442 }

    describe String do
      subject { ")" }

      it { expect(subject).to eq ")" }

      describe String do
        it { expect(subject).to eq ")" }
        it { expect(subject).not_to eq "boom" }

        describe Foo do
          subject { "#{super()}foooooooooop" }

          it { expect(subject).to eq ")foooooooooop" }
        end
      end

      let(:var1) { super() + 1 }

      # it "is pendinggggg"

      # it

      it "changed!!!!!!!!!!!!!!!!!!!!!!!!!!!" do
        puts "var1 ->>>> #{var1.inspect}"
      end
    end
  end

  describe Bar do
    before do
      # puts "before 2..."
    end

    it "will be initialized" do
      # puts "huhu"
      expect(3).to be 3
    end
  end
end
