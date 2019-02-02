class Solver
  def initialize
  end

  def solve(input)
    c, m = input.split("/")
    m = m.to_i
    ws = c.split(',').map(&:to_i)
    s = ws.last * (m - 1)
    e = (ws.last * m)

    idx_to_n = ->(idx) { (idx / ws.first) + 1 }

    ranges = []
    ws.reverse.each do |w|
      if s % w != 0
        s = s / w * w
      end
      if e % w != 0
        e = e / w * w + w
      end
      ranges.unshift [s, e, w]
    end

    # s - e までが対象
    ans = 0

    arr = []
    ranges.take(ranges.size - 1).each_with_index do |(s, e, w), i|
      ns, ne, nw = ranges[i + 1]

      tmp = s

      while tmp < ne do
        unless tmp <= ns
          tmp += w
          next
        end
        if found = (tmp...tmp+w).find { |num| num % nw == 0 }
          unless arr.include?(found)
            arr << found
            p = idx_to_n.call(found)
            puts "found: #{found} at tmp = #{tmp} and i = #{i} and p = #{p}"
            ans += p
          end
        end

        tmp += w
      end
    end

    ss = (s / ws.first) + 1
    ee = (e / ws.first)
    first_sum = (ss..ee).sum
    ans += first_sum
    (ans % 1000).to_s
  end
end
