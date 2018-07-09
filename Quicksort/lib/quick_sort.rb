class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot_idx = rand(array.length)
    pivot_val = array[pivot_idx]
    left = []
    right = []

    array.each_with_index do |el, idx|
      next if idx == pivot_idx
      if el < pivot_val
        left << el
      else
        right << el
      end
    end

    self.sort1(left) + [pivot_val] + self.sort1(right)
  end



  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    # return array if length <= 1
    # pivot_idx = self.partition(array, start, length, &prc)
    # left = pivot_idx - start
    # right = length - left - 1
    
    # self.sort2!(array, start, left, &prc)
    # self.sort2!(array, pivot_idx + 1, right, &prc)
    
    # array
    
    return array if length <= 1
    
    pivot_idx = partition(array, start, length, &prc)
    
    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    
    sort2!(array, start, left_length, &prc)
    sort2!(array, pivot_idx + 1, right_length, &prc)
    
    array
  end
  
  def self.partition(array, start, length, &prc)
    # prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    # pivot = array[start]
    # pivot_idx = start
    # (start + 1..array.length - 1).each do |idx|
    #   if prc.call(array[idx], pivot) == -1
    #     array[start + 1], array[idx] = array[idx], array[start + 1]
    #     start += 1
    #   end
    # end
    # array[pivot_idx], array[start] = array[start], array[pivot_idx]
    # start
    
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    
    pivot_idx = start
    pivot_val = array[pivot_idx]

    (start + 1...length + start).each do |idx|
      curr_val = array[idx]

      if prc.call(curr_val, pivot_val) < 0
        pivot_idx += 1
        array[pivot_idx], array[idx] = array[idx], array[pivot_idx]
      end
    end

    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
