require_relative 'tree'

# tree = Tree.new
tree = Tree.new(array: Array.new(15) { rand(1..100) })
tree.pretty_print(tree.root)
p tree.balanced?

p tree.level_order_recursive
p tree.level_order_iterative
puts "\n"
p tree.preorder
p tree.inorder
p tree.postorder
puts "\n"
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.pretty_print(tree.root)
p tree.balanced?
tree.rebalance
tree.pretty_print(tree.root)
p tree.balanced?

puts "\n"
p tree.level_order_recursive
p tree.level_order_iterative
puts "\n"
p tree.preorder
p tree.inorder
p tree.postorder
