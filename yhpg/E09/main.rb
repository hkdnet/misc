class Unit
  include Comparable
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def <=>(other)
    (x <=> other.x).tap { |e| break y <=> other.y if e == 0 }
  end

  def to_s
    "(#{x}, #{y})"
  end
end

class UnitManager
  class << self
    def find_or_create(x, y)
      k = key(x, y)
      stock[k] ||= Unit.new(x, y)
      stock[k]
    end

    def key(x, y)
      "#{x},#{y}"
    end

    def stock
      @stock ||= {}
    end
  end
end

class Position
  include Comparable
  attr_accessor :unit
  attr_accessor :idx

  def initialize(unit, idx)
    @unit = unit
    @idx = idx
  end

  def <=>(other)
    (unit <=> other.unit).tap { |e| break idx <=> other.idx if e == 0 }
  end

  def to_s
    "#{idx}@#{unit}"
  end
end

class Player
  attr_accessor :now
  attr_accessor :nex

  def initialize
    tmp = UnitManager.find_or_create(0, 0)
    @now = Position.new(tmp, 3)
    @nex = Position.new(tmp, 1)
  end

  def forward
    history.push(now.dup)
    tmp = now
    self.now = nex
    self.nex = tmp
  end

  def right
    nex.unit == now.unit ? inner_right : outer_right
  end

  def inner_right
    if now.idx == 1
      if nex.idx == 2
        u = UnitManager.find_or_create(now.unit.x, now.unit.y - 1)
        self.nex = Position.new(u, 4)
      elsif nex.idx == 3 || nex.idx == 4
        nex.idx -= 1
      else
        raise "???"
      end
    elsif now.idx == 2
      if nex.idx == 3
        u = UnitManager.find_or_create(now.unit.x, now.unit.y + 1)
        self.nex = Position.new(u, 1)
      elsif nex.idx == 1
        nex.idx = 3
      else
        raise "???"
      end
    elsif now.idx == 3
      if nex.idx == 4
        u = UnitManager.find_or_create(now.unit.x + 1, now.unit.y + 1)
        self.nex = Position.new(u, 2)
      elsif nex.idx == 1 || nex.idx == 2
        if nex.idx == 1
          nex.idx = 4
        else
          nex.idx = 1
        end
      else
        raise "???"
      end
    elsif now.idx == 4
      if nex.idx == 1
        u = UnitManager.find_or_create(now.unit.x + 1, now.unit.y - 1)
        self.nex = Position.new(u, 3)
      elsif nex.idx == 3
        nex.idx = 1
      else
        raise "???"
      end
    end
  end

  def outer_right
    if now.idx == 1
      if nex.idx == 4
        u = UnitManager.find_or_create(nex.unit.x + 1, nex.unit.y)
        self.nex = Position.new(u, 2)
      elsif nex.idx == 2
        self.nex = Position.new(now.unit, 4)
      end
    elsif now.idx == 3
      if nex.idx == 2
        u = UnitManager.find_or_create(nex.unit.x - 1, nex.unit.y)
        self.nex = Position.new(u, 4)
      elsif nex.idx == 4
        self.nex = Position.new(now.unit, 2)
      end
    elsif now.idx == 2
      if nex.idx == 4
        u = UnitManager.find_or_create(now.unit.x, now.unit.y + 1)
        self.nex = Position.new(u, 3)
      elsif nex.idx == 3
        self.nex = Position.new(now.unit, 1)
      elsif nex.idx == 1
        u = UnitManager.find_or_create(now.unit.x - 1, now.unit.y)
        self.nex = Position.new(u, 4)
      end
    elsif now.idx == 4
      if nex.idx == 2
        u = UnitManager.find_or_create(now.unit.x, now.unit.y + 1)
        self.nex = Position.new(u, 1)
      elsif nex.idx == 1
        self.nex = Position.new(now.unit, 3)
      elsif nex.idx == 3
        u = UnitManager.find_or_create(now.unit.x + 1, now.unit.y)
        self.nex = Position.new(u, 2)
      end
    end
  end

  def left
    4.times { |i| right }
  end

  def index
    history.index(now)
  end

  def history
    @history ||= []
  end
end

class Solver
  attr_reader :input
  def initialize(str)
    @input = str
  end

  def solve
    p = Player.new
    h, i = input.split('').each.with_index.find do |e, i|
      break h, p.history.size if h = p.index
      case e
      when 'F'
        p.forward
      when 'c'
        p.right
      when 'a'
        p.left
      end
      nil
    end
    h ? "visited #{h} #{i}" : '-'
  end
end

