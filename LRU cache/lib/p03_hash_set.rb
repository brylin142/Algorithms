require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    @store[key.hash % num_buckets] << key
    @count += 1
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    @store[key.hash % num_buckets].delete(key)
    @count -= 1
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = []
    @store.each { |bucket| temp += bucket }
    @store = Array.new(num_buckets * 2) { Array.new }
    temp.each { |num| @store[num % num_buckets] << num }
  end
end
