require './lib/tree'

RSpec.describe Tree do
  subject(:node) { described_class.new([1, 2, 3]) }
  
  describe '#root', root: true do
    let(:root_node) { Node.new }

    before do
      allow(node).to receive(:build_tree).and_return(root_node)
    end

    context 'when @root is not set' do
      it 'sends #build_tree message to node' do
        expect(node).to receive(:build_tree)
        node.root
      end

      it 'returns the value of @root' do
        expect(node.root).to eq(root_node)
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
        expect(node.root).to eq(root_node)
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
    let(:root_node) { Node.new }

    describe 'takes an array of data and turns it into a balance BST' do
      describe 'removes duplicates' do
        before do
          allow(array).to receive(:uniq).and_return(array_uniq)
          allow(array_uniq).to receive(:sort).and_return(array_sort)
        end

        it 'sends #uniq message to array' do
          expect(array).to receive(:uniq)
          node.build_tree
        end

        it 'sends #sort message to array_uniq' do
          expect(array_uniq).to receive(:sort)
          node.build_tree
        end

        it 'returns the root node of the created balanced BST' do
          allow(Node).to receive(:new).and_return(root_node)

          expect(node.build_tree).to eq(root_node)
        end
      end
    end
  end
end
