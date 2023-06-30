# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

require './lib/node'

# Tree represents a Binary Search Tree
class Tree
  include Comparable

  def initialize(array = nil)
    @array = array
  end

  def root
    @root ||= build_tree
  end

  def array
    @array ||= nil
  end

  def build_tree
    sorted_array = array.uniq.sort

    root_node = Node.new
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
