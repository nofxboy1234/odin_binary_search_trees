# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

# Tree represents a Binary Search Tree
class Tree
  include Comparable

  def initialize(array)
    @data = data
    @left = left
    @right = right
  end

  def root
    @data
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
