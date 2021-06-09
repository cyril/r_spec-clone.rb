# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe "described class" do
  it "does not implement the method" do
    expect { described_class }.to raise_exception(::RSpec::Error::UndefinedDescribedClass)
  end

  describe do
    describe Integer do
      it { expect(described_class).to be(Integer) }

      context 'inner' do
        describe String do
          it "is available as described_class" do
            expect(described_class).to be(String)
          end
        end
      end
    end
  end
end
