class Tree
  def initialize(size)
    @size = size
    @parents = size.times.map { |i| i }
  end

  def union(x, y)
    ry = root(y)
    @parents[ry] = root(x)
  end

  def root(x)
    arr = []
    while !root?(x)
      arr << x
      x = @parents[x]
    end
    arr.each { |idx| @parents[idx] = x }
    x
  end

  def root?(x)
    @parents[x] == x
  end

  def group_size
    s = 0
    0.upto(@size-1) do |i|
      s += 1 if root?(i)
    end
    s
  end
end

n, m = gets.chomp.split(' ').map(&:to_i)

tree = Tree.new(n)

(m).times do
  x, y, _ = gets.chomp.split(' ').map(&:to_i)
  tree.union(x - 1, y - 1)
end

puts tree.group_size

__END__
3
1 2 2
2 3 1

EEE
EOO

# x y z

## z が E のとき
x と y は同じ (x, y) = {(E,E), (O, O)}

2つの組について同じ/違うは等価な情報

Union Find で組に属していけばよい


