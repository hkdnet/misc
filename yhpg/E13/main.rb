class Field
  def initialize
    @field = [
      %w(_ _ a b c d e),
      %w(_ _ f g h i),
      %w(_ j k l m n),
      %w(_ o p q r),
      %w(s t u v w),
    ]
  end

  def point_of(char)
    y = field.index { |row| row.include?(char) }
    x = field[y].index(char)
    [x, y]
  end

  private

  attr_reader :field
end

class Mino
  def initialize(points)
    @points = points.sort
  end

  def type
    return 'I' if i?
    return 'D' if d?
    return 'B' if b?
    '-'
  end

  private

  attr_reader :points

  def i?
    linear?(points)
  end

  def b?
    p3 = points.combination(3).find { |e| linear?(e) }
    return false unless p3
    p = (points - p3).first
    nearbys = p3.select { |e| nearby?(e, p) }
    return false unless nearbys.size == 2
    # 直線上のくっついてないやつ
    pp = (p3 - nearbys).first
    # 直線上のくっついてるやつ
    ppp = (p3.minmax - [pp]).first
    # y = x + b <-> x - y + b = 0
    if ppp[0] - ppp[1] == pp[0] - pp[1]
      return true if p[0] - p[1] > 0
    end
    # y = -x + b <-> x + y - b = 0
    if ppp[0] + ppp[1] == pp[0] + pp[1]
      return true if p[0] + p[1] > 0
    end
    # y = b
    if ppp[1] == pp[1]
      return true if p[1] > pp[1]
    end
    # x = b
    if ppp[0] == pp[0]
      return true if p[0] > pp[0]
    end
    false
  end

  def d?
    p3 = points.combination(3).find { |e| linear?(e) }
    return false unless p3
    p = (points - p3).first
    nearbys = p3.select { |e| nearby?(e, p) }
    return false unless nearbys.size == 2
    !b?
  end

  def three?
    points.combination(3).any? { |e| linear?(e) }
  end

  def xs
    @xs ||= points.map(&:first)
  end

  def ys
    @ys ||= points.map(&:last)
  end

  def linear?(points)
    # xsの差があやしい
    # 差が-1のとき
    xs = points.map(&:first)
    return true if xs.all? { |e| e == xs[0] }
    ys = points.map(&:last)
    return true if ys.all? { |e| e == ys[0] }
    dxs = xs.each_cons(2).map { |a, b| a - b }
    dys = ys.each_cons(2).map { |a, b| a - b }
    if dxs.first.abs == 1 && dys.first.abs == 1 && dxs.all? { |e| e == dxs[0] } && dys.all? { |e| e == dys[0] }
      return true
    end
    false
  end

  # a b c
  #  d e f
  #   f g h
  def nearby?(a, b)
    return true if a[0] == b[0] && (a[1] - b[1]).abs == 1
    return true if a[1] == b[1] && (a[0] - b[0]).abs == 1
    # aとbの差がおおきいときも通る
    return true if a[1] - b[1] + a[0] - b[0] == 0
    false
  end
end

class Solver
  def initialize(id: nil)
    @id = id
  end

  def solve(input)
    field = Field.new
    points = input.split('').map { |e| field.point_of(e) }
    mino = Mino.new(points)
    mino.type
  end

  private

  attr_reader :id
end
