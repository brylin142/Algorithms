require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []
  count = {}
  vertices.each do |vertex| 
    queue << vertex if vertex.in_edges.empty?
    count[vertex] = vertex.in_edges.count
  end
  
  until queue.empty?
    top = queue.shift
    sorted << top
    top.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      count[to_vertex] -= 1
      queue << to_vertex if count[to_vertex] == 0
      # edge.destroy!
    end

  end
  sorted.length != vertices.length ? [] : sorted
end
