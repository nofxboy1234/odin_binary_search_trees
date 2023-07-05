require './practice/gear'
require './practice/wheel'

RSpec.describe Gear do
  subject(:gear) { described_class.new(
                                        chainring: 52, 
                                        cog: 11, 
                                        wheel: Wheel.new(26, 1.5)) }

  it 'calculates gear inches' do
    expect(gear.gear_inches).to be_within(0.01).of(137.1)
  end
end
