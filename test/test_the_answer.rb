require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

begin
  app = 6 * 7

  RSpec.describe 'test' do
    it { expect(app).to eql 42 }
  end
rescue SystemExit => e
  Spectus.this { e.success? }.MUST :BeTrue
end
