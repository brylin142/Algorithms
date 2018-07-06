class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
    @max = max
  end

  def insert(num)
    raise "Out of bounds" unless num.between?(0, 50)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % 20] << num
  end

  def remove(num)
    @store[num % 20].delete(num)
  end

  def include?(num)
    @store[num % 20].include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    @store[num % num_buckets] << num
    @count += 1
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
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
