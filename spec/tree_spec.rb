require './lib/tree'

RSpec.describe Tree do
  subject(:node) { described_class.new([1, 2, 3]) }
  
  describe '#root', root: true do
    context 'when @root is not set' do
      it 'sends #build_tree message to node' do
        expect(node).to receive(:build_tree)
        node.root
      end

      it 'returns the value of @root' do
        expect(node.root).to eq('tree')
      end
    end

    context 'when @root is set' do
      before do
        node.root
      end

      it 'does not send #build_tree message to node' do
        expect(node).to_not receive(:build_tree)
        node.root
      end

      it 'returns the value of @root' do
        expect(node.root).to eq('tree')
      end
    end
  end

  describe '#array', array: true do
    context 'when @array is not set' do
    subject(:node) { described_class.new }

      it 'returns nil' do
        expect(node.array).to eq(nil)
      end
    end

    context 'when @array is set' do
      it 'returns the value of @array' do
        expect(node.array).to eq([1, 2, 3])
      end
    end
  end

  describe '#build_tree', build_tree: true do
    subject(:node) { described_class.new(array) }
    let(:array) { double('array') }

    describe 'takes an array of data and turns it into a balance BST' do
      describe 'removes duplicates' do
        before do
          allow(array).to receive(:uniq)
        end

        it 'sends #uniq message to array' do
          expect(array).to receive(:uniq)
          node.build_tree
        end
      end
    end
  end
end
