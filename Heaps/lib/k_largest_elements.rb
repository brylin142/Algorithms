require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
  # array.heap_sort!.drop(array.length - k)

  heap = BinaryMinHeap.new
  array.each do |el|
    heap.push(el)
  end

  until heap.store.length == k
    heap.extract
  end
  heap.store
end