class BinaryMinHeap
  class << self
    def child_indices(len, parent_index)
      result = []
      result << 2 * parent_index + 1 if 2 * parent_index + 1 < len
      result << 2 * parent_index + 2 if 2 * parent_index + 2 < len
      result
    end
    
    def parent_index(child_index)
      raise "root has no parent" if child_index < 1
      (child_index - 1) / 2
    end
    
    def heapify_down(array, parent_index, len = array.length, &prc)
      prc ||= proc { |parent, child| parent <=> child }
      
      loop do
        child_indices = child_indices(len, parent_index)
        child_values = array.values_at(*child_indices)
        child_values_to_index = child_values.zip(child_indices).to_h
        
        min_child = child_values.sort(&prc).first
        parent = array[parent_index]
        
        break if min_child.nil?
        break unless prc.call(parent, min_child) == 1
        
        min_child_index = child_values_to_index[min_child]
        array[parent_index], array[min_child_index] = min_child, parent
        parent_index = min_child_index
      end
      
      array
    end
    
    def heapify_up(array, child_index, len = array.length, &prc)
      prc ||= proc { |parent, child| parent <=> child }
    
      until child_index.zero?
        parent_index = parent_index(child_index)
        parent = array[parent_index]
        child = array[child_index]
        
        break if prc.call(parent, child) == -1
    
        array[parent_index] = child
        array[child_index] = parent
        child_index = parent_index
      end
    
      array
    end
  end
  
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
  end

  def count
    store.length
  end

  def extract
    store[0], store[-1] = store[-1], store[0]
    val = store.pop
    self.class.heapify_down(store, 0)
    val
  end

  def peek
    raise "no element to peek" if count == 0
    store[0]
  end

  def push(val)
    store.push(val)
    self.class.heapify_up(store, store.length - 1)
  end
end
