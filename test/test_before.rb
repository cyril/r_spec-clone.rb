require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

begin
  RSpec.describe 'test' do
    before do
      let(:foo) { :foo }
    end

    it 'does something' do
      expect(foo).to be(:foo)
    end

    describe 'UPCASE' do
      before { described.upcase! }

      it { is_expected.to eq('UPCASE') }
    end
  end
rescue SystemExit => e
  Spectus.this { e.success? }.MUST :BeTrue
end
