# frozen_string_literal: true

# breadth-first traversal (level-order traversal)
# enqueue root -> initially start with 1 discovered node in the queue

# dequeue
# visit
# enqueue children -> discovered nodes

# if queue is empty
#     return
# end

Node = Struct.new('Node', :data, :left, :right)
# node = Node.new('data', 'left', 'right')

def level_order(root)
  return if root.nil?

  queue = []
  queue.push(root) # Enqueue

  while queue.length.positive? # At least 1 discovered node
    # Dequeue - Take node out from front of the queue
    current = queue.shift
    # Visit = Read data in the Node
    puts "#{current.data} "
    # Push the children of the Node into the queue (Enqueue)
    queue.push(current.left) if current.left
    queue.push(current.right) if current.right
  end
end

# function to insert Node in a Binary Search Tree
def insert(root, data)
  if root.nil?
    root = Node.new
    root.data = data
    root.left = root.right = nil
  elsif data <= root.data
    root.left = insert(root.left, data)
  else
    root.right = insert(root.right, data)
  end
  root
end

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

# Code To Test the logic
# Creating an example tree
#     M
#    / \
#   B   Q
#  / \   \
# A   C   Z

# root = nil
# root = insert(root, 'M')
# root = insert(root, 'B')
# root = insert(root, 'Q')
# root = insert(root, 'Z')
# root = insert(root, 'A')
# root = insert(root, 'C')

# def array_to_binary(array, root)
#   for e in array
#     root = insert(root, e)
#   end
#   root
# end

def array_to_binary(array, root)
  array.inject(root) do |memo, operand| 
    puts "memo: #{memo}"
    puts "operand: #{operand}"
    insert(memo, operand)
  end
end

array = %w[M B Q Z A C]
root = nil
root = array_to_binary(array, root)

pretty_print(root)
puts "\n"
puts 'level_order traversal:'
level_order(root)
