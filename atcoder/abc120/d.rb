n, m = gets.chomp.split(' ').map(&:to_i)
bridges = m.times.map { gets.chomp.split(' ').map(&:to_i) }

class UnionFind
  def initialize(size)
    @size = size
    @arr = size.times.map { |i| [i, 1] }
  end

  def unite(a, b)
    a = root(a)[0]
    b = root(b)[0]
    unite_p = a != b
    if unite_p
      @arr[a][1] += @arr[b][1]
      @arr[b] = @arr[a]
    end

    unite_p
  end

  def same?(a, b)
    root(a) == root(b)
  end

  def size_of(a)
    root(a)[1]
  end

  private

  def root(a)
    idx = @arr[a][0]
    if idx == a
      @arr[a]
    else
      @arr[idx] = root(idx)
    end
  end
end

f = UnionFind.new(n)
ans = []
ans << n*(n-1)/2

enough_p = false

bridges.reverse_each do |bridge|
  if enough_p
    ans.unshift(0)
    next
  end

  a, b = *bridge
  # 0-idnex
  a -= 1
  b -= 1

  a_size = f.size_of(a)
  b_size = f.size_of(b)

  if f.unite(a, b)
    v = ans[0] - a_size * b_size
    if v < 0
      enough_p = true
      ans.unshift(0)
    else
      ans.unshift(v)
    end
  else
    ans.unshift(ans[0])
  end
end

ans.drop(1).each { |a| puts a }
