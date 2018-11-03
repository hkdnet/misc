#http://nabetani.sakura.ne.jp/hena/orde28sqst/

require 'set'

class Solver
  Instruction = Struct.new(:dir, :size)

  class Board
    attr_reader :min_w, :max_w, :min_h, :max_h
    def initialize
      @board = {}
      @min_w = 0
      @max_w = 0
      @min_h = 0
      @max_h = 0
    end

    def debug
      max_h.downto(min_h) do |y|
        min_w.upto(max_w) do |x|
          print fetch(x,y)&.to_s(36)
        end
        print "\n"
      end
    end

    def fetch(x, y)
      @board.fetch(x, {})[y]
    end

    def rect(num, x1, x2, y1, y2)
      @min_w = x1 if x1 < min_w
      @max_w = x2 if x2 > max_w
      @min_h = y1 if y1 < min_h
      @max_h = y2 if y2 > max_h

      [x1, x2-1].each do |x|
        y1.upto(y2-1) do |y|
          @board[x] ||= {}
          @board[x][y] = num
        end
      end
      [y1, y2-1].each do |y|
        x1.upto(x2-1) do |x|
          @board[x] ||= {}
          @board[x][y] = num
        end
      end
    end

    def find_coor(num)
      @board.keys.sort.each do |x|
        @board[x].keys.sort.each do |y|
          return [x, y] if @board[x][y] == num
        end
      end

      debug

      raise 'not found'
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

    x1, y1 = board.find_coor(@target)
    x2 = x1
    x2 += 1 while board.fetch(x2, y1) == @target
    x2 -= 1
    y2 = y1
    y2 += 1 while board.fetch(x1, y2) == @target
    y2 -= 1

    found = Set.new
    [y1-1, y2+1].each do |y|
      (x1).upto(x2) do |x|
        found << board.fetch(x, y)
      end
    end

    [x1-1, x2+1].each do |x|
      (y1).upto(y2) do |y|
        found << board.fetch(x, y)
      end
    end

    # board.debug
    @board = board

    found.to_a.compact.sort.join(',')
  end

  def debug
    @board.debug
  end
end
