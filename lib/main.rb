require_relative 'tree'

tree = Tree.new(array: Array.new(15) { rand(1..100) })
# puts tree
# puts tree.root
# tree.pretty_print(tree.instance_variable_get(:@root))
p tree.balanced?