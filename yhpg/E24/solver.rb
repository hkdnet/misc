class Solver
  def solve(input)
    @b, @m = input.split(',').map(&:to_i)
    rank = 1
    count = 0


    loop do
      return '-' if rank > (@b - 1)
      # rank 個の仕切りを n - 1 箇所にいれればよい
      # rank 末尾と n の末尾になんか変なのいれてることに注意
      # → nCrankでよい
      tmp = count_for(n: @b - 1, k: rank)
      break if count + tmp >= @m
      count += tmp
      rank += 1
    end
    # 桁数確定
    tmp = (0...rank).map { |e| e + '1'.ord }.map(&:chr).join.to_i(@b)

    loop do
      # ここも count_for 使えるはずなんだけど
      if incr?(tmp)
        count += 1
        break if count == @m
      end
      tmp += 1
    end

    tmp.to_s(@b)
  end

  def count_for(n:, k:)
    raise ArgumentError if k > n

    ret = 1.0
    k.times do |i|
      ret = ret * (n - i) / (k - i)
    end
    ret.to_i
  end

  def incr?(num)
    tmp = num.to_s(@b).chars
    return true if tmp.size == 1
    tmp.each_cons(2).all? do |c1, c2|
      c1 < c2
    end
  end
end
