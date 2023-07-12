require './lib/tree'
require 'pry-byebug'

# Build Balanced BST: Stack -> *Recursion, Queue -> *Iteration,
# Breadth-First search: Queue -> Iteration, Stack -> Recursion
# Depth-First search: Stack -> Recursion

# Balanced: A balanced tree is one where the difference between heights of 
# left subtree and right subtree of every node is not more than 1.
# Advantages of Balanced BST
  # BST is fast in insertion, deletion, searching with a time complexity of O(log n).
# See: https://www.geeksforgeeks.org/applications-advantages-and-disadvantages-of-binary-search-tree/

# Valid for Binary Search:
  # The left child node is always less than the parent node.
  # The right child node is always greater than or equal to the parent node.

# When Inserting elements of an array left to right,
  # if the list is sorted, you'll get a Array-like structured BST 
  # that is always Unbalanced and Valid for Binary Search, but could just be an Array.
  
  # if the list is unsorted - depending on the order of the elements,
  # you can get a Balanced/Unbalanced BST, that is always Valid for Binary Search.

# When using Middle element algorithm,
  # if the list is sorted, you'll always get a Balanced BST that is Valid for Binary Search
  
  # if the list is unsorted, you'll always get a Balanced BST, that is invalid for Binary Search

RSpec.describe Tree do
  subject(:tree) { described_class.new(array: [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]) }

  describe '#root', root: true do
    let(:root_node) { double('root_node') }

    before do
      allow(tree).to receive(:build_tree_recursive).and_return(root_node)
    end

    context 'when array is not nil' do
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

        it 'does not send #build_tree_recursive to tree' do
          expect(tree).not_to receive(:build_tree_recursive)
        end
      end
    end

    context 'when array is nil' do
      subject(:tree) { described_class.new }

      it 'returns nil' do
        expect(tree.root).to eq(nil)
      end
    end

    it 'finds 2 Node instances with the same data value to be equal' do
      node1 = Node.new(data: 777)
      node2 = Node.new(data: 777)

      expect(node1).to eq(node2)
    end

    it 'finds a Node and Double instance with the same data value to be equal' do
      node1 = Node.new(data: 777)
      node2 = double('node2', data: 777)

      expect(node1).to eq(node2)
    end

    # let(:data_value) { 777 }

    it 'confirms that a node double has changed' do
      RSpec::Matchers.define :support_blocks do
        match do |actual|
          actual.is_a? Proc
        end

        supports_block_expectations
      end

      RSpec::Matchers.define :update do
        match do |actual|
          puts "actual: #{actual.call.data}"
          puts "block_arg: #{block_arg.call.data}"
          true
        end

        supports_block_expectations
      end

      data_value = 777
      node1 = double('node1', data: data_value)
      node2 = double('node2', data: data_value)

      # expect(node1).to eq(node2)
      # expect { node1.data += 1 }.to support_blocks
      # expect { node1.data = 1 }.to update { node1 }
      expect { node1 }.to update { node2 }
      # expect { 'hello' }.to update { 'goodbye' }
      # expect { node1.data += 1 }.to update { node1.data }
      # expect { tree.root }.not_to change { tree.instance_variable_get(:@root) }
    end
  end

  describe '#array', array: true do
    context 'when array is nil' do
      subject(:tree) { described_class.new }

      it 'returns nil' do
        expect(tree.array).to eq(nil)
      end
    end

    context 'when array is not nil' do
      it 'returns @array without duplicates and sorted' do
        expect(tree.array).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
      end
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
      context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
        # https://youtu.be/VCTP81Ij-EM?t=224
        it 'returns the root node (5) of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          expect(root_node.data).to eq(5)
          tree.pretty_print(root_node)
        end

        it 'sends .new message to Node exactly 9 times' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          
          expect(Node).to receive(:new).exactly(9).times.and_call_original
          root_node = tree.build_tree_recursive(array, start_index, end_index)

          tree.pretty_print(root_node)
        end
      end

      context 'when array is [1, 2, 3, 4, 5, 6, 7]' do
        subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7]) }

        it 'returns the root node (4) of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          expect(root_node.data).to eq(4)
          tree.pretty_print(root_node)
        end

        it 'sends .new message to Node exactly 7 times' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          
          expect(Node).to receive(:new).exactly(7).times.and_call_original
          root_node = tree.build_tree_recursive(array, start_index, end_index)

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
          root_node = tree.build_tree_iterative(array)
          expect(root_node.data).to eq(5)
          tree.pretty_print(root_node)
        end

        it 'sends .new message to Node exactly 9 times' do
          array = tree.array
          
          expect(Node).to receive(:new).exactly(9).times.and_call_original
          root_node = tree.build_tree_iterative(array)

          tree.pretty_print(root_node)
        end
      end

      context 'when array is [1, 2, 3, 4, 5, 6, 7]' do
        subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7]) }

        it 'returns the root node (4) of the built balanced BST' do
          array = tree.array
          root_node = tree.build_tree_iterative(array)
          expect(root_node.data).to eq(4)
          tree.pretty_print(root_node)
        end

        it 'sends .new message to Node exactly 7 times' do
          array = tree.array
          
          expect(Node).to receive(:new).exactly(7).times.and_call_original
          root_node = tree.build_tree_iterative(array)

          tree.pretty_print(root_node)
        end
      end
    end
  end

  describe '#level_order_iterative', level_order_iterative: true do
    describe 'accepts a block, traverses the tree in breadth-first level order and yields each node to the provided block' do
      context 'when no block is given' do
        context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
          it 'returns [5, 2, 7, 1, 3, 6, 8, 4, 9]' do
            tree.pretty_print(tree.root)
            level_order_array = [5, 2, 7, 1, 3, 6, 8, 4, 9]
            expect(tree.level_order_iterative).to eq(level_order_array)
          end
        end
      end

      context 'when a block is given' do
        context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
          context 'when block is { |node| "data: #{node.data}" }' do
            before do
              allow(tree).to receive(:puts)
            end

            it 'returns nil' do
              tree.pretty_print(tree.root)

              my_proc = Proc.new { |node| "data: #{node.data}" }
              expect(tree.level_order_iterative(&my_proc)).to eq(nil)
            end
            
            it 'sends #call message to my_proc exactly 9 times' do
              tree.pretty_print(tree.root)

              my_proc = Proc.new { |node| "data: #{node.data}" }
              expect(my_proc).to receive(:call).exactly(9).times.and_call_original
              tree.level_order_iterative(&my_proc)
            end
          end
        end
      end
    end
  end
end
