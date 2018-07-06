require_relative "heap"

class Array
  def heap_sort!
    each_index do |index|
      BinaryMinHeap.heapify_up(self, index) { |e1, e2| -(e1 <=> e2) }
    end
    
    each_index.reverse_each do |index|
      self[0], self[index] = self[index], self[0]
      BinaryMinHeap.heapify_down(self, 0, index) { |e1, e2| -(e1 <=> e2) }
    end
  end
end
