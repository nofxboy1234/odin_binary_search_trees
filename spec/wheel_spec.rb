require './practice/wheel'

RSpec.describe Wheel do
  subject(:wheel) { described_class.new(26, 1.5) }

  it 'calculates diameter' do
    expect(wheel.diameter).to eq(29)
  end
end
