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
    # 1. initialize start = 0, end = length of array - 1
    # 2. mid = (start_index + end_index) / 2
    # 3. create a tree node with mid as root (let's call it A)
    # recursively do following steps:
    # 4. calculate mid of left subarray and make it root of left subtree of A
    # 5. calculate mid of right subarray and make it root of right subtree of A

    subject(:node) { described_class.new(array) }
    let(:array) { double('array') }
    let(:array_uniq) { double('array_uniq') }
    let(:array_sort) { double('array_sort') }
    let(:root_node) { double('root_node') }

    describe 'takes an array of data and turns it into a balance BST' do
      describe 'removes duplicates' do
        before do
          allow(array).to receive(:uniq).and_return(array_uniq)
          allow(array_uniq).to receive(:sort).and_return(array_sort)
          allow(Node).to receive(:new).and_return(root_node)
        end

        xit 'sends #uniq message to array' do
          expect(array).to receive(:uniq)
          node.build_tree
        end

        xit 'sends #sort message to array_uniq' do
          expect(array_uniq).to receive(:sort)
          node.build_tree
        end

        xit 'sends #new message to Node' do
          expect(Node).to receive(:new)
          node.build_tree
        end

        xit 'returns the root node of the created balanced BST' do
          expect(node.build_tree).to eq(root_node)
        end
      end
    end
  end
end
