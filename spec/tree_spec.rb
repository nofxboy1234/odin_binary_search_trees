require './lib/tree'

# Build Balanced BST: Stack -> Recursion, Queue -> Iteration, 
# Breadth-First search: Queue -> Iteration, Stack -> Recursion
# Depth-First search: Stack -> Recursion

RSpec.describe Tree do
  subject(:tree) { described_class.new(array: [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]) }

  describe '#root', root: true do
    let(:root_node) { double('root_node') }

    before do
      allow(tree).to receive(:build_tree_recursive).and_return(root_node)
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
    it 'returns @array without duplicates and sorted' do
      expect(tree.array).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe '#build_tree_recursive', build_tree_recursive: true do
    # 1. initialize start_index = 0, end_index = length of array - 1
    # 2. mid_index = (start_index + end_index) / 2
    # 3. create a tree node with mid_index as root (let's call it A)
    # recursively do following steps:
    # 4. calculate mid_index of left subarray and make it root of left subtree of A
    # 5. calculate mid_index of right subarray and make it root of right subtree of A

    describe 'takes an array of data and turns it into a balanced BST' do
      context 'when array is %w[M B Q Z A C]' do
        subject(:tree) { described_class.new(array: %w[M B Q Z A C]) }

        it 'returns the root node (5) of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          expect(root_node.data).to eq('C')
          tree.pretty_print(root_node)
        end
      end

      context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
        it 'returns the root node (5) of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          expect(root_node.data).to eq(5)
          tree.pretty_print(root_node)
        end
      end

      context 'when array is [1, 2, 3, 4, 5, 6, 7]' do
        # https://youtu.be/VCTP81Ij-EM?t=224
        subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7]) }
  
        it 'returns the root node (4) of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          expect(root_node.data).to eq(4)
          tree.pretty_print(root_node)
        end
      end
    end
  end

  describe '#build_tree_iterative', build_tree_iterative: true do
    describe 'takes an array of data and turns it into a balance BST' do
      context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
        it 'returns the root node (5) of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_iterative(array)
          expect(root_node.data).to eq(5)
          tree.pretty_print(root_node)
        end
      end

      context 'when array is [1, 2, 3, 4, 5, 6, 7]' do
        subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7]) }
  
        it 'returns the root node (4) of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_iterative(array)
          expect(root_node.data).to eq(4)
          tree.pretty_print(root_node)
        end
      end
    end
  end
end
