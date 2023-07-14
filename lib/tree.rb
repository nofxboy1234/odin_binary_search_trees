# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

require './lib/node'

# Tree represents a Binary Search Tree
class Tree
  # def initialize(array = NilArray.new)
  def initialize(array: nil)
    @array = array
  end

  def root
    return if @array.nil?

    @root ||= build_tree_recursive(array, 0, array.length - 1)
  end

  def array
    return if @array.nil?

    @array.uniq.sort
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

  def pretty_print(node, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
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

    p "nodes #{nodes.flatten.map { |node| node.data }}"
    if block_given?
      nodes.flatten.each { |node| my_block.call(node) }
      nil
    else
      nodes.flatten.map { |node| node.data }
    end
  end

  def height_recursive(node)
    return -1 if node.nil?

    left_height = height_recursive(node.left)
    right_height = height_recursive(node.right)
    [left_height, right_height].max + 1
  end

  private

  def nodes_on_level(node, level, nodes = [])
    # return nodes if node.nil?
    return if node.nil?

    if level.zero?
      nodes.push(node)
      # nodes
    elsif level.positive?
      nodes_on_level(node.left, level - 1, nodes)
      nodes_on_level(node.right, level - 1, nodes)
    end
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
