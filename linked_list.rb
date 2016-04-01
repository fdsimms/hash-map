require_relative 'linked_list_node'

class LinkedList
  include Enumerable

  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def first
    head
  end

  def empty?
    self.head == nil
  end

  def insert(key, val)
    if empty?
      self.head = LinkedListNode.new(key, val)
    else
      cur_link = head
      until cur_link.following == nil
        cur_link = cur_link.following
      end

      cur_link.following = LinkedListNode.new(key, val, nil, cur_link)
    end
  end

  def get(key)
    return nil if empty?
    return head.val if head.key == key

    cur_link = head
    until cur_link.following == nil
      cur_link = cur_link.following
      return cur_link.val if cur_link.key == key
    end

    nil
  end

  def include?(key)
    return false if empty?
    return true if head.key == key

    cur_link = head
    until cur_link.following == nil
      cur_link = cur_link.following
      return true if cur_link.key == key
    end

    false
  end

  def remove(key)
    return nil if empty?

    cur_link = head

    if head.key == key
      return decapitate_list
    end

    until cur_link.following == nil
      if cur_link.key == key
        return unchain_link(cur_link)
      else
        cur_link = cur_link.following
      end
    end

    nil
  end

  def unchain_link(cur_link)
    cur_link.prev.following = cur_link.following
    cur_link.following.prev = cur_link.prev
    cur_link.prev = nil
    cur_link.following = nil

    cur_link
  end

  def decapitate_list
    return_val = head

    if head.following
      self.head = head.following
      head.prev.following = nil
      head.prev = nil
    else
      self.head = nil
    end

    return_val
  end

  def each(&blk)
    return nil if empty?

    blk.call(head)
    cur_link = head
    until cur_link.following == nil
      cur_link = cur_link.following
      blk.call(cur_link)
    end
  end
end
