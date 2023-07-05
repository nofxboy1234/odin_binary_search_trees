require './practice/gear'
require './practice/wheel'

RSpec.describe Gear do
  subject(:gear) do
    described_class.new(
      chainring: 52,
      cog: 11,
      wheel: Wheel.new(26, 1.5),
      observer: observer
    )
  end
  let(:observer) { double('observer') }

  describe '#gear_inches' do
    it 'calculates gear inches' do
      expect(gear.gear_inches).to be_within(0.01).of(137.1)
    end
  end

  describe '#set_cog' do
    before do
      allow(observer).to receive(:changed)
    end

    it 'sets cog to a new value' do
      # Send the message that causes the side-effect
      gear.set_cog(27)
      # Make an assertion about the value of the side-effect
      expect(gear.cog).to eq(27)
    end

    it 'notifies observers when cogs change' do
      expect(observer).to receive(:changed).with(52, 27)
      gear.set_cog(27)
    end
  end

  describe '#changed' do
  end
end
