# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

# Tree represents a Binary Search Tree
class Tree
  include Comparable

  def initialize(array)
    @array = array
  end

  def root
    @root ||= build_tree
  end

  def build_tree; end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
