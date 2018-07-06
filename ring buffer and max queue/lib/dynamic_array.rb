require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    val = @store[@length - 1]
    @store[@length-1] = nil
    @length -= 1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length + 1 > @capacity
    @length += 1
    @store[@length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0
    shifted = @store[0]
    result = StaticArray.new(@capacity)
    @length -= 1
    @length.times do |idx|
      result[idx] = @store[idx + 1]
    end
    @store = result
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length + 1 > @capacity
    result = StaticArray.new(@capacity)
    result[0] = val
    @length.times do |idx|
      result[idx + 1] = @store[idx]
    end
    @length += 1
    @store = result
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if @length == 0 || index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_arr = StaticArray.new(@capacity * 2)
    @capacity *= 2
    @length.times do |idx|
      new_arr[idx] = @store[idx]
    end
    @store = new_arr
  end
end
