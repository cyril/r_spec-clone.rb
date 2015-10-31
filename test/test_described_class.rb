require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

include Spectus

begin
  RSpec.describe Fixnum do
    it 'is available as described_class' do
      expect(described_class).to eq(Fixnum)
    end
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end

begin
  RSpec.describe Fixnum do
    describe String do
      it 'is available as described_class' do
        expect(described_class).to eq(String)
      end
    end
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end

begin
  RSpec.describe Fixnum do
    describe 'foo' do
      it 'is available as described_class' do
        expect(described_class).to eq(String)
      end
    end
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end
