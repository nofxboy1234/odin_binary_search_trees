require './lib/node'

RSpec.describe Node do
  subject(:node) { described_class.new }

  describe '#<=>', comparable: true do
    context 'when data is less than other.data' do
      subject(:node) { described_class.new(1) }
      let(:other_node) { described_class.new(2) }

      it 'returns true' do
        expect(node < other_node).to eq(true)
      end
    end
  end
end
