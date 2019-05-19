class Tree
  class Node
    attr_reader :id, :distance

    def initialize(id, distance)
      @id = id
      @distance = distance
    end

    def children
      @children ||= []
    end
  end

  def initialize(size)
    @size = size
    @nodes = []
    @info = {}
  end

  def add(x, y, d)
    d = d % 2
    @info[x] ||= []
    @info[x] << [y, d]
    @info[y] ||= []
    @info[y] << [x, d]
  end

  def build
    @root = Node.new(1, 0)
    @nodes[@root.id] = @root
    q = [@root.id]
    until q.empty? do
      id = q.shift
      node = @nodes[id]
      @info[id].each do |c, d|
        next unless @nodes[c].nil?

        d = node.distance + d
        n = Node.new(c, d % 2)
        @nodes[c] = n
        node.children << n

        q << c
      end
    end
  end

  def colors
    @nodes.drop(1).map(&:distance)
  end
end

def print_node(node, indent = 0)
  puts ' ' * indent + node.id.to_s
  node.children.each do |c|
    print_node(c, indent + 2)
  end
end

n = gets.chomp.to_i

t = Tree.new(n)

(n-1).times do
  u, v, w = gets.chomp.split(' ').map(&:to_i)
  t.add(u, v, w)
end

t.build
t.colors.each do |c|
  puts c
end
