require './lib/tree'

# Build Balanced BST: Stack -> *Recursion, Queue -> *Iteration,
# Breadth-First search: Queue -> *Iteration, Stack -> *Recursion
# Depth-First search: Stack -> *Recursion

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
    let(:root_node2) { double('root_node2') }

    before do
      allow(tree).to receive(:build_tree_recursive).and_return(root_node, root_node2)
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

        it 'returns the root node' do
          expect(tree.root).to be(root_node)
        end
      end
    end

    context 'when array is nil' do
      subject(:tree) { described_class.new }

      it 'returns the root node' do
        expect(tree.root).to be(root_node)
      end
    end
  end

  describe '#array', array: true do
    context 'when array is nil' do
      subject(:tree) { described_class.new }

      it 'returns []' do
        expect(tree.array).to eq([])
      end
    end

    context 'when array is not nil' do
      it 'returns @array without duplicates and sorted' do
        expect(tree.array).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end
  end

  describe '#build_tree', build_tree: true do
    # 1. initialize start_index = 0, end_index = length of array - 1
    # 2. mid_index = (start_index + end_index) / 2
    # 3. create a tree node with mid_index as root (let's call it A)
    # recursively do following steps:
    # 4. calculate mid_index of left subarray and make it root of left subtree of A
    # 5. calculate mid_index of right subarray and make it root of right subtree of A

    describe 'takes an array of data and turns it into a balanced BST' do
      context 'when buildtree algorithm = "recursive"' do
        context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
          # https://youtu.be/VCTP81Ij-EM?t=224
          it 'returns the root node (5) of the built balanced BST' do
            root_node = tree.build_tree
            expect(root_node.data).to eq(5)
  
            tree.pretty_print(root_node)
          end
  
          it 'sends .new message to Node exactly 9 times' do
            expect(Node).to receive(:new).exactly(9).times.and_call_original
            root_node = tree.build_tree
            
            tree.pretty_print(root_node)
          end
        end
  
        context 'when array is [1, 2, 3, 4, 5, 6, 7]' do
          subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7]) }
  
          it 'returns the root node (4) of the built balanced BST' do
            root_node = tree.build_tree
            expect(root_node.data).to eq(4)
            
            tree.pretty_print(root_node)
          end
  
          it 'sends .new message to Node exactly 7 times' do
            expect(Node).to receive(:new).exactly(7).times.and_call_original
            root_node = tree.build_tree
  
            tree.pretty_print(root_node)
          end
        end
      end

      context 'when buildtree algorithm = "iterative"' do
        context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
          # https://youtu.be/VCTP81Ij-EM?t=224
          it 'returns the root node (5) of the built balanced BST' do
            root_node = tree.build_tree('iterative')
            expect(root_node.data).to eq(5)
  
            tree.pretty_print(root_node)
          end
  
          it 'sends .new message to Node exactly 9 times' do
            expect(Node).to receive(:new).exactly(9).times.and_call_original
            root_node = tree.build_tree('iterative')
            
            tree.pretty_print(root_node)
          end
        end
  
        context 'when array is [1, 2, 3, 4, 5, 6, 7]' do
          subject(:tree) { described_class.new(array: [1, 2, 3, 4, 5, 6, 7]) }
  
          it 'returns the root node (4) of the built balanced BST' do
            root_node = tree.build_tree('iterative')
            expect(root_node.data).to eq(4)
            
            tree.pretty_print(root_node)
          end
  
          it 'sends .new message to Node exactly 7 times' do
            expect(Node).to receive(:new).exactly(7).times.and_call_original
            root_node = tree.build_tree('iterative')
  
            tree.pretty_print(root_node)
          end
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
            let(:my_proc) { my_proc = Proc.new { |node| p "data: #{node.data}" } }

            before do
              allow(tree).to receive(:puts)
            end

            it 'returns nil' do
              tree.pretty_print(tree.root)

              expect(tree.level_order_iterative(&my_proc)).to eq(nil)
            end
            
            it 'sends #call message to my_proc exactly 9 times' do
              tree.pretty_print(tree.root)

              expect(my_proc).to receive(:call).exactly(9).times.and_call_original
              tree.level_order_iterative(&my_proc)
            end
          end
        end
      end
    end
  end

  describe '#level_order_recursive', level_order_recursive: true do
    describe 'accepts a block, traverses the tree in breadth-first level order and yields each node to the provided block' do
      context 'when no block is given' do
        context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
          it 'returns [5, 2, 7, 1, 3, 6, 8, 4, 9]' do
            tree.pretty_print(tree.root)
            level_order_array = [5, 2, 7, 1, 3, 6, 8, 4, 9]
            expect(tree.level_order_recursive).to eq(level_order_array)
          end
        end
      end

      context 'when a block is given' do
        context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
          context 'when block is { |node| "data: #{node.data}" }' do
            let(:my_proc) { my_proc = Proc.new { |node| p "data: #{node.data}" } }

            before do
              allow(tree).to receive(:puts)
            end

            it 'returns nil' do
              tree.pretty_print(tree.root)

              expect(tree.level_order_recursive(&my_proc)).to eq(nil)
            end
            
            it 'sends #call message to my_proc exactly 9 times' do
              tree.pretty_print(tree.root)

              expect(my_proc).to receive(:call).exactly(9).times.and_call_original
              tree.level_order_recursive(&my_proc)
            end
          end
        end
      end
    end
  end

  describe '#height', height: true do
    context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
      it 'returns -1 for height of non-existent node(100)' do
        tree.pretty_print(tree.root)
        expect(tree.height(Node.new(data: 100))).to eq(-1)
      end
      
      it 'returns 3 for height of root node' do
        tree.pretty_print(tree.root)
        tree.pretty_print(tree.find(100))
        tree.pretty_print(Node.new(data: 100))
        tree.pretty_print(Node.new(data: 2))

        expect(tree.height(tree.root)).to eq(3)
      end

      it 'returns 0 for height of node(6)' do
        tree.pretty_print(tree.root)
        expect(tree.height(Node.new(data: 6))).to eq(0)
      end

      it 'returns 0 for height of node(9)' do
        tree.pretty_print(tree.root)
        expect(tree.height(Node.new(data: 9))).to eq(0)
      end

      it 'returns 2 for height of node(2)' do
        tree.pretty_print(tree.root)
        expect(tree.height(Node.new(data: 2))).to eq(2)
      end
    end

    context 'when tree is empty' do
      subject(:tree) { described_class.new }

      it 'returns -1 for any node' do
        tree.pretty_print(tree.root)
        tree.pretty_print(tree.find(7))
        tree.pretty_print(Node.new(data: 100))

        expect(tree.height(Node.new(data: 2))).to eq(-1)
      end
    end
  end

  describe '#insert', insert: true do
    context 'when the tree is not empty' do
      context 'when value does not exist in the tree' do
        it 'inserts a new leaf node' do
          expect { tree.insert(10) }.to change { tree.level_order_recursive }
            .from([5, 2, 7, 1, 3, 6, 8, 4, 9]).to([5, 2, 7, 1, 3, 6, 8, 4, 9, 10])
        end
      end
  
      context 'when value exists in the tree' do
        it 'does not change the tree' do
          expect { tree.insert(9) }.not_to change { tree.level_order_recursive }
        end
      end
    end

    context 'when the tree is empty' do
      subject(:tree) { described_class.new }

      it 'inserts a new leaf node' do
        expect { tree.insert('F') }.to change { tree.level_order_recursive }
          .from([]).to(['F'])
      end
    end
  end

  describe '#find', find: true do
    context 'when a node with the value is in the tree' do
      it 'returns the node with the given value' do
        expect(tree.find(9)).to eq(Node.new(data: 9))
      end
    end

    context 'when a node with the value is not in the tree' do
      it 'returns nil' do
        expect(tree.find(100)).to eq(nil)
      end
    end
  end

  describe '#delete', delete: true do
    context 'when a node with the given value does not exist' do
      it 'does not change the tree' do
        expect { tree.delete(100) }.not_to change { tree.level_order_recursive }
      end
    end

    context 'when a node with the given value exists' do
      context 'when the node is a leaf node - 9' do
        it 'deletes a node with the given value' do
          expect { tree.delete(9) }.to change { tree.level_order_recursive }
            .from([5, 2, 7, 1, 3, 6, 8, 4, 9]).to([5, 2, 7, 1, 3, 6, 8, 4])
        end
          
        it 'returns nil when trying to find the deleted value' do
          tree.delete(9)
          expect(tree.find(9)).to eq(nil)
        end
        
        it 'sets the right value of node(8) to nil' do
          tree.delete(9)
          expect(tree.find(8).right).to eq(nil)
        end
      end

      context 'when the node has 1 child (deleting node(8))' do
        it 'replaces the node with its child (point its parent to its child - bypass)' do
          expect { tree.delete(8) }.to change { tree.level_order_recursive }
          .from([5, 2, 7, 1, 3, 6, 8, 4, 9]).to([5, 2, 7, 1, 3, 6, 9, 4])
        end

        it 'returns nil when trying to find the deleted value' do
          tree.delete(8)
          expect(tree.find(8)).to eq(nil)
        end

        it 'sets the right value of node(7) to node(9)' do
          tree.delete(8)
          expect(tree.find(7).right).to eq(Node.new(data: 9))
        end
      end

      context 'when the node has 2 children (deleting node(2))' do
        # Be consistent about which subtree (left or right), is used when deleting.
        # The first node found that has no left subtree, is the smallest node in its subtree
        it 'replaces the node with the smallest node in its right subtree' do
          expect { tree.delete(2) }.to change { tree.level_order_recursive }
          .from([5, 2, 7, 1, 3, 6, 8, 4, 9]).to([5, 3, 7, 1, 4, 6, 8, 9])
        end

        it 'returns nil when trying to find the deleted value' do
          tree.delete(2)
          expect(tree.find(2)).to eq(nil)
        end

        it 'sets the left value of node(5) to node(3)' do
          tree.delete(2)
          expect(tree.find(5).left).to eq(Node.new(data: 3))
        end
        # The first node found that has no right subtree, is the largest node in its subtree
        # xit 'replaces the node with the largest node in its left subtree' do
          
        # end
      end
    end
  end

  describe '#preorder', preorder: true do
    describe 'accepts a block, traverses the tree in depth-first preorder and yields each node to the provided block' do
      context 'when level_order_recursive is %w[F D J B E G K A C I]' do
        subject(:tree) { described_class.new }
  
        before do
          %w[F D J B E G K A C I].each { |value| tree.insert(value) }
          tree.pretty_print(tree.root)
        end

        context 'when no block is given' do
          it 'returns %w[F D B A C E J G I K]' do
            expect(tree.preorder).to eq(%w[F D B A C E J G I K])
          end
        end

        context 'when a block is given' do
          context 'when block is { |node| "data: #{node.data}" }' do
            let(:my_proc) { my_proc = Proc.new { |node| p "data: #{node.data}" } }
  
            it 'returns nil' do
              allow(my_proc).to receive(:call)
              expect(tree.preorder(&my_proc)).to eq(nil)
            end
            
            it 'sends #call message to my_proc exactly 10 times' do
              expect(my_proc).to receive(:call).exactly(10).times.and_call_original
              tree.preorder(&my_proc)
            end
          end
        end
      end
    end
  end

  describe '#inorder', inorder: true do
    describe 'accepts a block, traverses the tree in depth-first inorder and yields each node to the provided block' do
      context 'when level_order_recursive is %w[F D J B E G K A C I]' do
        subject(:tree) { described_class.new }
  
        before do
          %w[F D J B E G K A C I].each { |value| tree.insert(value) }
          tree.pretty_print(tree.root)
        end

        context 'when no block is given' do
          it 'returns %w[A B C D E F G I J K]' do
            expect(tree.inorder).to eq(%w[A B C D E F G I J K])
          end
        end

        context 'when a block is given' do
          context 'when block is { |node| "data: #{node.data}" }' do
            let(:my_proc) { my_proc = Proc.new { |node| p "data: #{node.data}" } }
  
            it 'returns nil' do
              allow(my_proc).to receive(:call)
              expect(tree.inorder(&my_proc)).to eq(nil)
            end
            
            it 'sends #call message to my_proc exactly 10 times' do
              expect(my_proc).to receive(:call).exactly(10).times.and_call_original
              tree.inorder(&my_proc)
            end
          end
        end
      end
    end
  end

  describe '#postorder', postorder: true do
    describe 'accepts a block, traverses the tree in depth-first postorder and yields each node to the provided block' do
      context 'when level_order_recursive is %w[F D J B E G K A C I]' do
        subject(:tree) { described_class.new }
  
        before do
          %w[F D J B E G K A C I].each { |value| tree.insert(value) }
          tree.pretty_print(tree.root)
        end

        context 'when no block is given' do
          it 'returns %w[A C B E D I G K J F]' do
            expect(tree.postorder).to eq(%w[A C B E D I G K J F])
          end
        end

        context 'when a block is given' do
          context 'when block is { |node| "data: #{node.data}" }' do
            let(:my_proc) { my_proc = Proc.new { |node| p "data: #{node.data}" } }
  
            it 'returns nil' do
              allow(my_proc).to receive(:call)
              expect(tree.postorder(&my_proc)).to eq(nil)
            end
            
            it 'sends #call message to my_proc exactly 10 times' do
              expect(my_proc).to receive(:call).exactly(10).times.and_call_original
              tree.postorder(&my_proc)
            end
          end
        end
      end
    end
  end

  describe '#depth', depth: true do
    context 'when array is [9, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]' do
      it 'returns -1 for depth of non-existent node(100)' do
        tree.pretty_print(tree.root)
        expect(tree.depth(Node.new(data: 100))).to eq(-1)
      end
      
      it 'returns 0 for depth of root node' do
        tree.pretty_print(tree.root)
        expect(tree.depth(tree.root)).to eq(0)
      end

      it 'returns 2 for depth of node(6)' do
        tree.pretty_print(tree.root)
        expect(tree.depth(Node.new(data: 6))).to eq(2)
      end

      it 'returns 3 for depth of node(9)' do
        tree.pretty_print(tree.root)
        expect(tree.depth(Node.new(data: 9))).to eq(3)
      end

      it 'returns 1 for depth of node(2)' do
        tree.pretty_print(tree.root)
        expect(tree.depth(Node.new(data: 2))).to eq(1)
      end
    end
  end

  describe '#balanced?', balanced: true do
    context 'when tree is balanced' do
      it 'returns true' do
        tree.pretty_print(tree.root)
        expect(tree).to be_balanced 
      end

      it 'returns true' do
        tree.insert(10)
        tree.insert(7.5)
        tree.insert(5.5)
        tree.pretty_print(tree.root)
        expect(tree).to be_balanced 
      end
    end
    
    context 'when tree is unbalanced' do
      before do
        tree.insert(10)
        tree.pretty_print(tree.root)
      end
  
      it 'returns false' do
        expect(tree).not_to be_balanced 
      end
    end
  end

  describe '#rebalance', rebalance: true do
    # context 'when tree is balanced' do
    #   it 'returns true' do
    #     tree.pretty_print(tree.root)
    #     expect(tree).to be_balanced 
    #   end

    #   it 'returns true' do
    #     tree.insert(10)
    #     tree.insert(7.5)
    #     tree.insert(5.5)
    #     tree.pretty_print(tree.root)
    #     expect(tree).to be_balanced 
    #   end
    # end
    
    context 'when tree is unbalanced' do
      before do
        tree.insert(10)
        tree.pretty_print(tree.root)
      end
  
      it 'rebalances the tree' do
        tree.rebalance
        expect(tree).to be_balanced 
      end

      after do
        puts "\n"
        tree.pretty_print(tree.root)
      end
    end
  end

end
