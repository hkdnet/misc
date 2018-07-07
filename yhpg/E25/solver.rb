class Solver
  Pair = Struct.new(:x, :y) do
    def add(other)
      Pair.new(x + other.x, y + other.y)
    end

    def sub(other)
      Pair.new(x - other.x, y - other.y)
    end

    def multi(s)
      Pair.new(x * s, y * s)
    end

    def rotate270
      Pair.new(-y, x)
    end

    def to_s
      "(#{x},#{y})"
    end

    def size
      Math.sqrt(x**2 + y**2)
    end
  end

  def solve(input)
    w, h, str = input.split(',', 3)
    @w = w.to_i
    @h = h.to_i
    x, y = str.scan(/\d+/).map(&:to_i)
    answer = {}
    s = Pair.new(x, y)

    @w.times do |sx|
      @h.times do |sy|
        v = Pair.new(sx, sy).sub(s)
        ps = points(s, v)
        if ps.all? { |p| valid?(p) }
          l = v.size
          answer[l] ||= []
          answer[l] << ps
        end
      end
    end

    m = answer.keys.max
    if answer[m].size == 1 && m != 0
      answer[m].first.map(&:to_s).join(",")
    else
      '-'
    end
  end

  def valid?(p)
    (0...@w).include?(p.x) && (0...@h).include?(p.y)
  end

  def points(s, v)
    p1 = s.add(v)
    p2 = p1.add(v.rotate270)
    p3 = p2.sub(v.multi(2))
    [p1, p2, p3]
  end
end
