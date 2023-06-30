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
      # before do
      #   allow(node).to receive(:build_tree).and_return('tree')
      # end

      it 'returns the value of @array' do
        expect(node.array).to eq([1, 2, 3])
      end
    end
  end

  # describe '#build_tree', build_tree: true do
  #   describe 'takes an array of data and turns it into a balance BST' do
  #     describe 'removes duplicates' do
  #       it 'sends #uniq'
  #     end
  #   end
  # end
end
