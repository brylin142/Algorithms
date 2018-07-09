# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root, :count
  
  def initialize
    @root = nil
    @count = 0
  end

  def insert(value)
    @root.nil? ? @root = BSTNode.new(value) : insert_rec(@root, value)
    @count += 1
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    if value == tree_node.value
      return tree_node
    elsif value <= tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    return @root = nil if @root.value == value
    parent = get_parent(value, @root)

    if parent.left.value == value && no_children(parent.left)
      parent.left = nil
    elsif parent.right.value == value && no_children(parent.right)
      parent.right = nil
    end

    if parent.right && parent.right.left.nil? && parent.right.value == value
      parent.right = parent.right.right
    elsif parent.left && parent.left.left.nil? && parent.left.value == value
      parent.left = parent.left.right
    end

    if parent.left && parent.left.value == value
      max = maximum(parent.left.left)
      max_parent = get_parent(max.value)
      removed_node = parent.left
      parent.left = max
      max_parent.right = max.left
      max.left = removed_node.left
      max.right = removed_node.right
    end

    @count -= 1
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    max = tree_node
    until max.right.nil?
      max = max.right
    end
    max
  end

  def depth(tree_node = @root)
    Math.log2(@count).ceil
  end 

  def is_balanced?(tree_node = @root)
    max_depth(tree_node) == depth(tree_node)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] unless tree_node
    left = in_order_traversal(tree_node.left)
    right = in_order_traversal(tree_node.right)
    left + [tree_node.value] + right
  end


  private
  def insert_rec(root, value)
    if root.nil?
      root = BSTNode.new(value)
    elsif (value <= root.value)
      root.left = insert_rec(root.left, value)
    else
      root.right = insert_rec(root.right, value)
    end
    root
  end

  def get_parent(value, node=@root)
    return nil if node.nil?
    if node.left.value == value || node.right.value == value
      return node
    elsif node.value > value
      get_parent(value, node.left)
    elsif node.value < value
      get_parent(value, node.right)
    else
      nil
    end
  end

  def no_children(node)
    node.left.nil? && node.right.nil?
  end

  def max_depth(node)
    return 0 if !node
    left = max_depth(node.left)
    right = max_depth(node.right)

    left > right ? left + 1 : right + 1
  end

end
