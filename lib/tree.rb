# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

require './lib/node'
require 'pry-byebug'

# Tree represents a Binary Search Tree
class Tree
  # def initialize(array = NilArray.new)
  def initialize(array: nil)
    @array = array
  end

  def root
    return if @array.nil?

    if @root
      # @root.data = 999

      # @root = Node.new
      # binding.pry
      old_root = @root.clone
      @root = Node.new(data: 777)
      # @root
      # @root = Node.new(data: 999)
    else
      @root = build_tree_recursive(array, 0, array.length - 1)
    end
  end

  def array
    # @array ||= NilArray.new
    # @array ||= []
    return if @array.nil?

    @array
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

  def level_order
    return if root.nil?

    queue = []
    queue.push(root)

    values = []
    while queue.length.positive?
      current = queue.shift
      values.push(current.data)
      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
    end

    values
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
