# Hash Map

## Summary

This is a simple implementation of a hash map in Ruby that I did for fun. It could feasibly replace Ruby's built-in Hash class.  

## Usage

A HashMap can be initialized simply using `HashMap.new`, and you can optionally give it an array of subarrays containing a key and value in order to instantiate it with those keys and values. From there, a number of methods based on Ruby's built-in Hash class are available, such as `get`/`[]`, `insert`/`[]=` and `include?`/`has_key?` It includes the `Enumerable` module, so favorite methods such as `each` and `map` work like a charm.

## How Does It Work?
  The HashMap is initialized with a number of buckets, which take the form of doubly linked lists whose links store a key and value. When a new item is inserted into the HashMap, a hashing operation is performed on that item's key, which is then modulo'd to find which bucket it belongs in. The item is then inserted at the end of the LinkedList represented by the bucket. If the number of items exceeds the number of buckets, the number of buckets is automatically doubled in order to keep the runtime complexity to a minimum.
