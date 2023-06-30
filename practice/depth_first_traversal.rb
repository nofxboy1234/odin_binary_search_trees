# frozen_string_literal: true

Node = Struct.new('Node', :data, :left, :right)

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

def preorder(root)
  return if root.nil?

  puts root.data.to_s
  preorder(root.left)
  preorder(root.right)
end

def inorder(root)
  return if root.nil?

  inorder(root.left)
  puts root.data.to_s
  inorder(root.right)
end

def postorder(root)
  return if root.nil?

  postorder(root.left)
  postorder(root.right)
  puts root.data.to_s
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

root = nil
root = insert(root, 'M')
root = insert(root, 'B')
root = insert(root, 'Q')
root = insert(root, 'Z')
root = insert(root, 'A')
root = insert(root, 'C')

pretty_print(root)
puts "\n"
puts 'preorder traversal:'
preorder(root)
puts "\n"
puts 'inorder traversal:'
inorder(root)
puts "\n"
puts 'postorder traversal:'
postorder(root)
