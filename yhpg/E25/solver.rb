class Solver
  def initialize
  end

  def solve(input)
    w, h, str = input.split(',', 3)
    @w = w.to_i
    @h = h.to_i
    x, y = str.scan(/\d+/).map(&:to_i)
    answer = {}
    s = [x, y]

    @w.times do |sx|
      @h.times do |sy|
        v = [sx - x, sy - y]
        ps = points(s, v)
        if ps.all? { |p| valid?(p) }
          l = len_of(v)
          answer[l] ||= []
          answer[l] << ps
        end
      end
    end

    m = answer.keys.max
    if answer[m].size == 1 && m != 0
      answer[m].first.map { |p| "(#{p.first},#{p.last})" }.join(",")
    else
      '-'
    end
  end

  def len_of(v)
    Math.sqrt(v.first**2 + v.last**2)
  end

  def valid?(p)
    (0...@w).include?(p.first) && (0...@h).include?(p.last)
  end

  def points(s, v)
    sx, sy = s
    a, b = v
    p1 = [sx + a, sy + b]
    p2 = [p1.first - b, p1.last + a]
    p3 = [p2.first - 2*a, p2.last - 2*b]
    [p1, p2, p3]
  end
end
