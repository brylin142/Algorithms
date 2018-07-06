require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
    @store[(@length + @start_idx) % @capacity]
    # self[@length]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length + 1 > @capacity
    @store[(@length + @start_idx) % @capacity] = val
    # self[@length] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shifted = self[0]
    @length -= 1
    @start_idx += 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length + 1 > @capacity
    @start_idx -= 1
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  def resize!
    new_arr = StaticArray.new(@capacity * 2)
    @length.times do |idx|
      new_arr[(@start_idx + idx) % @capacity] = @store[idx]
    end
    @capacity *= 2
    @store = new_arr
    @start_idx = 0
  end
end
