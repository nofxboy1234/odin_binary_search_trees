# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

require './lib/node'
require 'pry-byebug'
require './lib/byebug_syntax_highlighting'

# Tree represents a Binary Search Tree
class Tree
  def initialize(array: nil)
    @array = array
  end

  def root
    @root || build_tree
  end

  def array
    return [] if @array.nil?

    @array.uniq.sort
  end

  def build_tree(algorithm = 'recursive')
    if algorithm == 'recursive'
      @root = build_tree_recursive(array, 0, array.length - 1)
    elsif algorithm == 'iterative'
      @root = build_tree_iterative(array)
    end
  end

  def pretty_print(node, prefix = '', is_left = true)
    return if node.nil?

    found_node = find(node.data)
    return unless found_node

    pretty_print(found_node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if found_node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{found_node.data}"
    pretty_print(found_node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if found_node.left
  end

  def level_order_iterative(&my_block)
    return if root.nil?

    queue = []
    queue.push(root)

    values = []
    while queue.length.positive?
      current = queue.shift

      if block_given?
        puts my_block.call(current)
      else
        values.push(current.data)
      end

      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
    end

    values unless block_given?
  end

  def level_order_recursive(&my_block)
    nodes = (0..height_recursive(root)).map do |level|
      nodes_on_level(root, level)
    end

    if block_given?
      nodes.flatten.each { |node| my_block.call(node) }
      nil
    else
      nodes.flatten.map { |node| node.data }
    end
  end

  def height(node)
    found_node = find(node.data)
    return -1 unless found_node

    height_recursive(found_node)
  end

  def depth(node)
    depth_recursive(root, node)
  end

  def insert(value)
    @root = insert_recursive(root, value)
  end

  def find(value)
    find_recursive(root, value)
  end

  def delete(value)
    delete_recursive(root, value)
  end

  def preorder(&my_block)
    preorder_recursive(root, &my_block)
  end

  def inorder(&my_block)
    inorder_recursive(root, &my_block)
  end

  def postorder(&my_block)
    postorder_recursive(root, &my_block)
  end

  def balanced?
    # byebug
    return true unless root

    balance_status = []
    preorder do |node|
      # byebug
      height_left = if node.left
                      height(node.left)
                    else
                      0
                    end

      height_right = if node.right
                       height(node.right)
                     else
                       0
                     end

      is_balanced = (height_left - height_right).abs <= 1
      balance_status << is_balanced
    end
    balance_status.all?
  end

  def rebalance
    return unless root
    return if balanced?

    @array = preorder.uniq.sort
    build_tree
  end

  private

  def height_recursive(node)
    return -1 if node.nil?

    left_height = height_recursive(node.left)
    right_height = height_recursive(node.right)
    [left_height, right_height].max + 1
  end

  def build_tree_recursive(array, start_index, end_index)
    return if start_index > end_index

    mid_index = (start_index + end_index) / 2

    left = build_tree_recursive(array, start_index, mid_index - 1)
    right = build_tree_recursive(array, mid_index + 1, end_index)
    Node.new(data: array[mid_index], left: left, right: right)
  end

  def build_tree_iterative(array)
    return if array.empty?

    mid_index = array.length / 2
    root = Node.new(data: array[mid_index])

    queue = [[root, [0, mid_index - 1]],
             [root, [mid_index + 1, array.length - 1]]]

    while queue.length.positive?
      parent, start_index, end_index = queue.shift.flatten

      next if (start_index > end_index) && parent

      mid_index = (start_index + end_index) / 2
      child = Node.new(data: array[mid_index])

      if child < parent
        parent.left = child
      else
        parent.right = child
      end

      queue.push([child, [start_index, mid_index - 1]])
      queue.push([child, [mid_index + 1, end_index]])
    end

    root
  end

  def depth_recursive(root, node)
    return -1 unless find(node.data)

    if node == root
      return 0
    end

    if node < root
      height = depth_recursive(root.left, node)
    elsif node > root
      height = depth_recursive(root.right, node)
    end

    height + 1
  end

  def preorder_recursive(root, values = [], &my_block)
    return if root.nil?

    if block_given?
      my_block.call(root)
    else
      values.push(root.data)
    end

    preorder_recursive(root.left, values, &my_block)
    preorder_recursive(root.right, values, &my_block)

    values unless block_given?
  end

  def inorder_recursive(root, values = [], &my_block)
    return if root.nil?

    inorder_recursive(root.left, values, &my_block)

    if block_given?
      my_block.call(root)
    else
      values.push(root.data)
    end

    inorder_recursive(root.right, values, &my_block)

    values unless block_given?
  end

  def postorder_recursive(root, values = [], &my_block)
    return if root.nil?

    postorder_recursive(root.left, values, &my_block)
    postorder_recursive(root.right, values, &my_block)

    if block_given?
      my_block.call(root)
    else
      values.push(root.data)
    end

    values unless block_given?
  end

  def delete_recursive(root, value)
    return nil if root.nil?

    if root.data == value
      if root.leaf?
        # Set the parent's left or right to be nil
        return nil
      elsif root.has_one_child?
        # Set the parent's left or right to be the only child
        return root.left || root.right
      elsif root.has_two_children?
        min_child = min_of_right_subtree_recursive(root.right)
        # Set the min child's left to be the current left node
        min_child.left = root.left
        # Set the parent's left or right to be the child with min value
        return min_child
      end
    end

    if value < root.data
      root.left = delete_recursive(root.left, value)
    elsif value > root.data
      root.right = delete_recursive(root.right, value)
    end

    root
  end

  def min_of_right_subtree_recursive(root)
    if root.left.nil?
      return root
    else
      min_of_right_subtree_recursive(root.left)
    end
  end

  def find_recursive(root, value)
    return root if root.nil? || root.data == value

    if value < root.data
      find_recursive(root.left, value)
    elsif value > root.data
      find_recursive(root.right, value)
    end
  end

  def insert_recursive(root, value)
    return Node.new(data: value) if root.nil?

    if value < root.data
      root.left = insert_recursive(root.left, value)
    elsif value > root.data
      root.right = insert_recursive(root.right, value)
    end

    root
  end

  def nodes_on_level(node, level, nodes = [])
    return if node.nil?

    if level.zero?
      nodes.push(node)
    elsif level.positive?
      nodes_on_level(node.left, level - 1, nodes)
      nodes_on_level(node.right, level - 1, nodes)
    end

    nodes
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors

