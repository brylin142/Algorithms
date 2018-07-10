# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'graph'
require 'topological_sort'
require 'install_order'

def install_order(arr)
  max_id = arr.map { |tuple| tuple.first }.max
  packages = (1..max_id).map { |n| Vertex.new(n) }

  arr.each do |package_id, dependency|
    Edge.new(packages[dependency - 1], packages[package_id - 1])
  end

  topological_sort(packages).map { |package| package.value }
end
