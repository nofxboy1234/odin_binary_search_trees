require './lib/node'

RSpec.describe Node do
  
  describe '#data', data: true do
    context 'when @data is not set' do
      subject(:node) { described_class.new }

      it 'returns nil' do
        expect(node.data).to eq(nil)
      end
    end

    context 'when @data is set' do
      subject(:node) { described_class.new(1) }

      it 'returns the value of @data' do
        expect(node.data).to eq(1)
      end
    end
  end

  describe '#left', left: true do
    context 'when @left is not set' do
      subject(:node) { described_class.new }

      it 'returns nil' do
        expect(node.left).to eq(nil)
      end
    end

    context 'when @left is set' do
      subject(:node) { described_class.new(2, 1) }

      it 'returns the value of @left' do
        expect(node.left).to eq(1)
      end
    end
  end

  describe '#right', right: true do
    context 'when @right is not set' do
      subject(:node) { described_class.new }

      it 'returns nil' do
        expect(node.right).to eq(nil)
      end
    end

    context 'when @right is set' do
      subject(:node) { described_class.new(2, 1, 3) }

      it 'returns the value of @right' do
        expect(node.right).to eq(3)
      end
    end
  end


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
