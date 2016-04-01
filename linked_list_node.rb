class LinkedListNode
  attr_accessor :following, :prev, :val, :key

  def initialize(key, val, following = nil, prev = nil)
    @key = key
    @val = val
    @following = following
    @prev = prev
  end
end
