class HashMap
  include Enumerable

  attr_accessor :set, :size, :num_buckets

  def initialize(vals = [])
    @num_buckets = 5
    @set = Array.new(@num_buckets) { LinkedList.new }
    @size = 0
    vals.each { |val| insert(val) } unless vals.empty?
  end

  def insert(key, val)
    return val if include?(key)
    if size == num_buckets
      resize
      insert(key, val)
    else
      self.size += 1
      set[key.hash % num_buckets].insert(key, val)
    end

    val
  end

  def resize
    self.num_buckets *= 2
    new_set = Array.new(num_buckets) { LinkedList.new }

    set.each do |bucket|
      bucket.each do |linked_list|
        idx = linked_list.key.hash % num_buckets
        new_set[idx].insert(linked_list.key, linked_list.val)
      end
    end

    self.set = new_set
  end

  def remove(key)
    idx = key.hash % num_buckets

    bucket = set[idx]
    self.size -= 1

    if bucket.include?(key)
      bucket.remove(key)
    end
  end

  def include?(key)
    idx = key.hash % num_buckets

    set[idx].include?(key)
  end

  def each(&blk)
    set.each do |bucket|
      bucket.each do |node|
        blk.call(node.key, node.val)
      end
    end
  end
end
