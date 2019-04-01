def read_i
  gets.chomp.split(' ').map(&:to_i)
end

class Solver
  attr_reader :n

  def initialize(n, q, s, spells)
    @n = n
    @q = q
    @s = s
    @spells = spells
    @memo = {}
  end

  def search(dir)
    l = 1
    r = @n + 1
    loop do
      break if r - l == 1
      n = (r + l) / 2
      if shrink_r?(dir, solve(n))
        r = n
      else
        l = n
      end
    end
    l
  end

  def shrink_r?(dir, ans)
    return true if ans == :r_out
    return false if ans == :l_out
    dir == :L
  end

  def solve(n)
    @memo[n] ||=
      begin
        cur = n
        @spells.each do |target, d|
          next if target != @s[cur - 1]
          if d == 'L'
            cur -= 1
          else
            cur += 1
          end
          return :l_out if cur == 0
          return :r_out if cur == @n + 1
        end

        :alive
      end
  end
end


n, q = read_i
s = gets.chomp.chars
spells = q.times.map { gets.chomp.split(' ') }
solver = Solver.new(n, q, s, spells)

l = solver.search(:L)
r = solver.search(:R)

puts r - l

__END__
3 4
ABC
A L
B L
B R
A R
