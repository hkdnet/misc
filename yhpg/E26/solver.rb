require 'json'

class Solver
  # x は横
  # y はたて
  class Board
    def initialize(size, src)
      @size = size
      @board = src.split(',').map do |line|
        line.chars.map { |e| e.to_i % 4 }
      end
    end

    def rotate(x, y)
      raise '!?' unless include?(x, y)

      incr(x, y)
      decr(x, y + 1)
      decr(x, y - 1)
      decr(x + 1, y)
      decr(x - 1, y)
    end

    # 最終行まで上から揃えておく
    def try(commands = [])
      (1...@size).each do |y1|
        (1..@size).each do |x1|
          y0 = y1 - 1
          x0 = x1 - 1
          loop do
            # require 'pry'; binding.pry
            break commands if @board[y0][x0] == 1
            rotate(x0, y0+1)
            commands << [x1, y1 + 1]
          end
        end
      end
    end

    def solved?
      @board[@size - 1].all? { |e| e == 1 }
    end

    def show
      @board.each do |line|
        puts line.join(' ')
      end
    end

    def apply!(seed)
      seed.commands.each do |(x1, y1)|
        rotate(x1 - 1, y1 - 1)
      end
    end

    private

    def incr(x, y)
      return unless include?(x, y)
      @board[y][x] += 1
      normalize(x, y)
    end

    def decr(x, y)
      return unless include?(x, y)
      @board[y][x] -= 1
      normalize(x, y)
    end

    def normalize(x, y)
      return unless include?(x, y)
      @board[y][x] %= 4
    end

    def include?(x, y)
      return false if x < 0
      return false if y < 0
      return false if x >= @size
      return false if y >= @size
      true
    end
  end

  class Seed
    attr_reader :commands, :n

    def initialize(n)
      @n = n
      @commands = []
      to_s.chars.reverse_each.with_index do |c, idx|
        cnt = c.to_i
        @commands += Array.new(cnt) { [idx + 1, 1] }
      end
    end

    def next_seed
      Seed.new(@n + 1)
    end

    def to_s
      @n.to_s(4)
    end
  end

  def initialize(data)
    @number = data['number']
    @src = data['src']
    size, @board_src = @src.split('|')
    @size = size.to_i
  end

  def solve
    seed = Seed.new(0)
    cmds = loop do
      board = build_board
      board.apply!(seed)

      commands = seed.commands.dup
      board.try(commands)
      if board.solved?
        break commands
      end
      seed = seed.next_seed
    end
    "#{@number} #{format(cmds)}"
  end

  def format(commands)
    commands.map { |e| "#{e[0]},#{e[1]}" }.join("|")
  end

  private

  def build_board
    Board.new(@size, @board_src)
  end
end
