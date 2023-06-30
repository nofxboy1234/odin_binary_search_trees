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

    context 'when data is not less than other.data' do
      subject(:node) { described_class.new(3) }
      let(:other_node) { described_class.new(2) }

      it 'returns false' do
        expect(node < other_node).to eq(false)
      end
    end

    context 'when data is equal to other.data' do
      subject(:node) { described_class.new(1) }
      let(:other_node) { described_class.new(1) }

      it 'returns true' do
        expect(node == other_node).to eq(true)
      end
    end

    context 'when data is between two other nodes data' do
      subject(:node) { described_class.new(2) }
      let(:other_node) { described_class.new(1) }
      let(:other_node2) { described_class.new(3) }

      it 'returns true' do
        expect(node.between?(other_node, other_node2)).to eq(true)
      end
    end
  end
end
