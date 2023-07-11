require './lib/tree'

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
    let(:root_node) { Node.new(data: 0) }
    
    before do
      # binding.pry
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
        RSpec::Matchers.define :have_changed do
          match do |actual|
            puts "actual.data: #{actual.data}"
            puts "tree.instance_variable_get(:@root).data: #{tree.instance_variable_get(:@root).data}"
            actual != tree.instance_variable_get(:@root)
          end
          failure_message_when_negated do |actual|
            # puts "------------FAIL"
            "Oops! Expected @root not to have changed."
          end
        end

        before do
          tree.root
        end

        it 'does not change the value of @root' do
          # binding.pry
          # p tree.instance_variable_get(:@root)
          # tree.root
          # p tree.instance_variable_get(:@root)
          # expect { tree.root }.not_to change { tree.instance_variable_get(:@root) }

          root = tree.instance_variable_get(:@root).clone
          puts "root.data before #{root.data}"
          tree.root
          puts "root.data after #{tree.instance_variable_get(:@root).data}"
          expect(root).not_to have_changed
        end

        it 'does not change the value of @root' do
          p tree.instance_variable_get(:@root)
          tree.root
          p tree.instance_variable_get(:@root)
        end

        it 'does not change the value of @root' do
          expect { tree.root }.to change { tree.instance_variable_get(:@root) }
        end

        it 'changes number' do
          num = 1
          expect { num += 1 }.not_to change { num }
        end
      end
    end

    context 'when array is nil' do
      subject(:tree) { described_class.new }

      it 'returns nil' do
        expect(tree.root).to eq(nil)
      end
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
      end

      context 'when array is ("A".."K").to_a' do
        subject(:tree) { described_class.new(array: ('A'..'K').to_a) }

        it 'returns the root node ("F") of the built balanced BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          expect(root_node.data).to eq('F')
          tree.pretty_print(root_node)
        end
      end

      context 'when array is ("A".."K").to_a.shuffle' do
        subject(:tree) { described_class.new(array: ('A'..'K').to_a.shuffle) }

        it 'prints the BST' do
          array = tree.array
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          tree.pretty_print(root_node)
        end
      end

      context 'when array is [1, 5, 7, 20, 14, 10, 8]' do
        subject(:tree) { described_class.new(array: [1, 5, 7, 20, 14, 10, 8]) }

        it 'prints the BST' do
          array = tree.array
          puts "#{array}\n\n"
          start_index = 0
          end_index = array.length - 1
          root_node = tree.build_tree_recursive(array, start_index, end_index)
          # expect(root_node.data).to eq('F')
          tree.pretty_print(root_node)
        end
      end

      # context 'when array is [1, 5, 7, 20, 14, 10, 8].shuffle' do
      #   subject(:tree) { described_class.new(array: [1, 5, 7, 20, 14, 10, 8].shuffle) }

      #   it 'prints the BST' do
      #     array = tree.array
      #     puts "#{array}\n\n"
      #     start_index = 0
      #     end_index = array.length - 1
      #     root_node = tree.build_tree_recursive(array, start_index, end_index)
      #     # expect(root_node.data).to eq('F')
      #     tree.pretty_print(root_node)
      #   end
      # end
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
      end

      context 'when array is [1, 2, 3, 4, 5, 6, 7]' do
        subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7]) }

        it 'returns the root node (4) of the built balanced BST' do
          array = tree.array
          root_node = tree.build_tree_iterative(array)
          expect(root_node.data).to eq(4)
          tree.pretty_print(root_node)
        end
      end

      context 'when array is ("A".."K").to_a' do
        subject(:tree) { described_class.new(array: ('A'..'K').to_a) }

        it 'returns the root node ("F") of the built balanced BST' do
          array = tree.array
          root_node = tree.build_tree_iterative(array)
          expect(root_node.data).to eq('F')
          tree.pretty_print(root_node)
        end
      end
    end
  end

  describe '#level_order', level_order: true do
    describe 'accepts a block, traverses the tree in breadth-first level order and yields each node to the provided block' do
      context 'when no block is given' do
        context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
          it 'returns [5, 2, 7, 1, 3, 6, 8, 4, 9]' do
            tree.pretty_print(tree.root)
            level_order_array = [5, 2, 7, 1, 3, 6, 8, 4, 9]
            expect(tree.level_order).to eq(level_order_array)
          end
        end
      end
    end
  end
end
