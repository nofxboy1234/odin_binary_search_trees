# frozen_string_literal: true

class Node
  include Comparable

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end
  
  def data
    @data
  end

  def left
    @left
  end

  def right
    @right
  end

end
