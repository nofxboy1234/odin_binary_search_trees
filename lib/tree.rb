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
    @root ||= build_tree_recursive(array, 0, array.length - 1)
  end

  def array
    # @array ||= NilArray.new
    # @array ||= []
    @array.uniq.sort
  end

  def build_tree_recursive(array, start_index, end_index)
    return if start_index > end_index

    mid_index = (start_index + end_index) / 2

    left = build_tree_recursive(array, start_index, mid_index - 1)
    right = build_tree_recursive(array, mid_index + 1, end_index)
    @root = Node.new(data: array[mid_index], left: left, right: right)
  end

  def build_tree_iterative(nums)
    return if nums.empty?

    mid = nums.length / 2
    root = Node.new(data: nums[mid])

    q = [[root, [0, mid - 1]], [root, [mid + 1, nums.length - 1]]]

    while q.length.positive?
      parent, left, right = q.shift.flatten

      if left <= right && parent
        mid = (left + right) / 2
        child = Node.new(data: nums[mid])

        if nums[mid] < parent.data
          parent.left = child
        else
          parent.right = child
        end

        q.push([child, [left, mid - 1]])
        q.push([child, [mid + 1, right]])
      end
    end

    root
  end

  def pretty_print(node, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
