require 'json'

# x は横
# y はたて
class Solver
  def initialize(data)
    @number = data['number']
    @src = data['src']
    size, tmp = @src.split('|')
    @size = size.to_i
    @board = tmp.split(',').map do |line|
      line.chars.map { |e| e.to_i % 4 }
    end
    @commands = []
  end

  def solve
    # 最終行まで上から揃えておく
    (1...@size).each do |y1|
      (1..@size).each do |x1|
        y0 = y1 - 1
        x0 = x1 - 1
        loop do
          break if @board[y0][x0] == 1
          rotate(y0+1, x0)
        end
      end
    end
    show
  end

  private

  def show
    @board.each do |line|
      puts line.join(' ')
    end
  end

  def rotate(x, y)
    incr(y, x)
    decr(y + 1, x)
    decr(y - 1, x)
    decr(y, x + 1)
    decr(y, x - 1)
  end

  def incr(x, y)
    return unless check(x, y)
    @board[y][x] += 1
    normalize(x, y)
  end

  def decr(x, y)
    return unless check(x, y)
    @board[y][x] -= 1
    normalize(x, y)
  end

  def normalize(x, y)
    return unless check(x, y)
    @board[y][x] %= 4
  end

  def check(x, y)
    return false if x < 0
    return false if y < 0
    return false if x >= @size
    return false if y >= @size
    true
  end
end
