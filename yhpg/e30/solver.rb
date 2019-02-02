class Solver
  def initialize
  end

  def solve(input)
    c, m = input.split("/")
    m = m.to_i
    ws = c.split(',').map(&:to_i)
    s = ws.last * (m - 1)
    e = (ws.last * m)

    ws.reverse.each do |w|
      if s % w != 0
        s = s / w * w
      end
      if e % w != 0
        e = e / w * w + w
      end
      puts "#{s}-#{e}"
    end

    ss = (s / ws.first) + 1
    ee = (e / ws.first)
    ((ss..ee).sum % 1000).to_s
  end
end
