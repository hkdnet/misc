class Solver
  Point = Struct.new(:x, :y, keyword_init: true) do
    include Comparable

    def <=>(other)
      [x + y, -y] <=> [other.x + other.y, -other.y]
    end
  end

  def self.parse(input)
    input.split(',').map(&:to_i)
  end

  # @param input [Array<Integer>]
  def solve(input)
    b = Hash.new { |h, k| h[k] = {} }

    sqs = [] # (size, (x, y))

    k_by_size = {}

    input.each.with_index do |s, idx|
      enum = Enumerator.new do |yielder|
        init_k = 0
        s.downto(0) do |ss|
          if k_by_size[ss]
            init_k = k_by_size[ss]
            break
          end
        end
        (init_k..).each do |k|
          (0..k).each do |x|
            y = k - x
            yielder << [x, y] if b[x][y].nil?
          end
        end
      end

      loop do
        x, y = enum.next

        not_ok = (x..x + s - 1).any? do |xx|
          (y..y + s - 1).any? do |yy|
            !b[xx][yy].nil?
          end
        end
        next if not_ok

        k_by_size[s] = x + y

        s.times do |dx|
          s.times do |dy|
            b[x + dx][y + dy] = idx
          end
        end

        sqs << [s, [x, y]]
        break
      end
    end

    s, arr = sqs.max
    x, y = arr
    adj_idx = Set.new
    [y - 1, y + s].each do |yy|
      (x..x + s - 1).each do |xx|
        adj_idx << b[xx][yy] if b[xx][yy]
      end
    end
    [x - 1, x + s].each do |xx|
      (y..y + s - 1).each do |yy|
        adj_idx << b[xx][yy] if b[xx][yy]
      end
    end

    adj_idx.map { |idx| input[idx] }.sort.join(',')
  end

  def print_board(h)
    size = 100
    (0..size).each do |dy|
      y = size - dy
      (0..size).each do |x|
        print h[x][y] || 'x'
      end
      puts
    end
    puts '---'
  end
end
