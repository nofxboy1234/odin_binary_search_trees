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
    @root ||= build_tree(array, 0, array.length - 1)
  end

  def array
    # @array ||= NilArray.new
    # @array ||= []
    @array.uniq.sort
  end

  def build_tree(array, start_index, end_index)
    return if start_index > end_index

    mid_index = (start_index + end_index) / 2

    left = build_tree(array, start_index, mid_index - 1)
    right = build_tree(array, mid_index + 1, end_index)
    @root = Node.new(data: array[mid_index], left: left, right: right)
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
