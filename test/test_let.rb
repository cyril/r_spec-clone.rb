require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

begin
  RSpec.describe 'test' do
    let(:value) { described.length }

    it 'does something' do
      expect(value).to eq(4)
    end
  end
rescue SystemExit => e
  Spectus.this { e.success? }.MUST :BeTrue
end
