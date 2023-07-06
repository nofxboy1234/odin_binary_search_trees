require './lib/tree'

RSpec.describe Tree do
  subject(:tree) { described_class.new(array: [1, 2, 3]) }

  describe '#root', root: true do
    let(:root_node) { double('root_node') }

    before do
      allow(tree).to receive(:build_tree).and_return(root_node)
    end

    it 'returns the root node' do
      expect(tree.root).to be(root_node)
    end

    context 'when @root is not set' do
      it 'builds the tree and assigns the root node to @root' do
        expect { tree.root }.to change { tree.instance_variable_get(:@root) }
          .from(nil).to(root_node)
      end
    end

    context 'when @root is set' do
      before do
        tree.root
      end

      it 'does not change the value of @root' do
        expect { tree.root }.not_to change { tree.instance_variable_get(:@root) }
      end
    end
  end

  describe '#array', array: true do
    it 'returns @array' do
      expect(tree.array).to eq([1, 2, 3])
    end
  end

  describe '#build_tree', build_tree: true do
    # 1. initialize start_index = 0, end_index = length of array - 1
    # 2. mid = (start_index + end_index) / 2
    # 3. create a tree node with mid as root (let's call it A)
    # recursively do following steps:
    # 4. calculate mid of left subarray and make it root of left subtree of A
    # 5. calculate mid of right subarray and make it root of right subtree of A

    subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7, 8, 9]) }
    # subject(:tree) { described_class.new(array) }

    describe 'takes an array of data and turns it into a balance BST' do
      before do
      end

      it 'returns the root node of the created balanced BST' do
        array = tree.array
        start_index = 0
        end_index = array.length - 1
        root_node = tree.build_tree(array, start_index, end_index)
        expect(root_node.data).to eq(5)
      end

    end
  end
end
