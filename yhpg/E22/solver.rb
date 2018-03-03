class Solver
  def solve(input)
    @m, @n, @b, @x = input.split(',').map(&:to_i)
    arr = (@m..@n).map { |e| e.to_s(@b) }
    arr.sort[@x - 1].to_i(@b).to_s
  end
end
