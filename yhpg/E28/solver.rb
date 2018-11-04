#http://nabetani.sakura.ne.jp/hena/orde28sqst/

require 'set'

class Solver
  Instruction = Struct.new(:dir, :size)
  Sq = Struct.new(:num, :x1, :x2, :y1, :y2) do
    def cover?(x, y)
      x1 <= x && x <= x2 && y1 <= y && y <= y2
    end

    def neighbor?(other)
      if h_match?(other)
        x2 == other.x1 || x1 == other.x2
      elsif v_match?(other)
        y2 == other.y1 || y1 == other.y2
      end
    end

    def v_match?(other)
      !((x1...x2).to_a & (other.x1...other.x2).to_a).empty?
    end

    def h_match?(other)
      !((y1...y2).to_a & (other.y1...other.y2).to_a).empty?
    end
  end

  class Board
    attr_reader :min_w, :max_w, :min_h, :max_h
    def initialize
      @min_w = 0
      @max_w = 0
      @min_h = 0
      @max_h = 0
      @sqs = []
    end

    def fetch(x, y)
      @sqs.find { |e| e.cover?(x, y) }&.num
    end

    def neighbors(num)
      t = @sqs.find { |e| e.num == num }
      @sqs.select { |e| t.neighbor?(e) }.sort_by(&:num)
    end

    def rect(num, x1, x2, y1, y2)
      @min_w = x1 if x1 < min_w
      @max_w = x2 if x2 > max_w
      @min_h = y1 if y1 < min_h
      @max_h = y2 if y2 > max_h
      @sqs << Sq.new(num, x1, x2, y1, y2)
    end
  end

  def initialize
    @base = 1 # base_size
  end

  def solve(input)
    a, b = input.split('/', 2)
    @target = b.to_i
    @insns = a.chars.each_slice(2).map do |s|
      Instruction.new(s[0].to_sym, s[1].to_i)
    end

    @insns.each do |insn|
      @base *= insn.size
    end

    board = Board.new
    board.rect(1, 0, @base, 0, @base)

    n = 1

    @insns.each.with_index do |insn, i|
      minw = board.min_w
      maxw = board.max_w
      minh = board.min_h
      maxh = board.max_h
      case insn.dir
      when :N, :S
        tmp_base = (maxw - minw) / insn.size
      else
        tmp_base = (maxh - minh) / insn.size
      end
      1.upto(insn.size) do |d|
        case insn.dir
        when :N
          x2 = minw + (tmp_base * d)
          x1 = x2 - tmp_base
          y1 = maxh
          y2 = maxh + tmp_base
        when :S
          x2 = minw + (tmp_base * d)
          x1 = x2 - tmp_base
          y2 = minh
          y1 = minh - tmp_base
        when :E
          y1 = maxh - (tmp_base * d)
          y2 = y1 + tmp_base
          x1 = maxw
          x2 = maxw + tmp_base
        when :W
          y1 = maxh - (tmp_base * d)
          y2 = y1 + tmp_base
          x2 = minw
          x1 = minw - tmp_base
        end

        board.rect(n+d, x1, x2, y1, y2)
      end
      n += insn.size
    end

    board.neighbors(@target).map(&:num).join(',')
  end
end
