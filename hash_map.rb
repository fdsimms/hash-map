require_relative 'linked_list'

class HashMap
  include Enumerable

  attr_accessor :set, :size, :num_buckets

  def initialize(items = [])
    @num_buckets = 5
    @set = Array.new(@num_buckets) { LinkedList.new }
    @size = 0

    unless items.empty?
      items.each do |item|
        key = item.first
        val = item.last
        insert(key, val)
      end
    end
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

  alias :[]= :insert

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

  def get(key)
    idx = key.hash % num_buckets

    set[idx].each do |node|
      return node.val if node.key == key
    end

    nil
  end

  alias :[] :get

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

  alias :has_key? :include?

  def each(&blk)
    set.each do |bucket|
      bucket.each do |node|
        blk.call(node.key, node.val)
      end
    end
  end

  def inspect
    all_items = map { |key, val| "#{key} => #{val}"}.join(", ")
    "{#{all_items}}".inspect
  end
end
