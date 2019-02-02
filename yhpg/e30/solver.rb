class Solver
  def initialize
  end

  def solve(input)
    c, m = input.split("/")
    m = m.to_i
    ws = c.split(',').map(&:to_i)
    s = ws.last * (m - 1)
    e = (ws.last * m)

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

    results = []


    ranges.each_with_index do |(s, e, w), i|
      ps, pe, pw = ranges[i - 1]
      tmp = s
      while tmp < e

        tmp += w
      end
    end
  end
end
