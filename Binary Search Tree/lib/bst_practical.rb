def kth_largest(tree_node, k)
  arr = in_order_traversal(tree_node)
  arr[-k]
end

def in_order_traversal(tree_node = @root, arr = [])
  return [] unless tree_node
  left = in_order_traversal(tree_node.left)
  right = in_order_traversal(tree_node.right)
  left + [tree_node] + right
end