class Point
  class << self
    def from_char(char)
      i = char.to_i(36)
      i.divmod(6).reverse
    end
  end
end

class Solver
  VWALL = '27BEFHJNPSXY'.each_char.map { |e| Point.from_char(e).freeze }.freeze
  HWALL = '8ADEGHJLQRUWZ'.each_char.map { |e| Point.from_char(e).freeze }.freeze

  def solve(input)
    s = input[0]
    g = input[1]
    sp = point_of s
    gp = point_of g
    Searcher.new(sp, gp).min_step.to_s
  end

  class Searcher
    def initialize(start, goal)
      @start = start
      @goal = goal
      @queue = []
    end

    def min_step
      @min_step ||= search
    end

    def search
      reached = {}
      @queue << [@start, 0, reached]
      until @queue.empty?  # ループでいいはずなんだけど
        from, steps, reached = @queue.shift
        reached[from] = true
        return steps if @goal == from
        [
          [from.first, from.last + 1],
          [from.first, from.last - 1],
          [from.first + 1, from.last],
          [from.first - 1, from.last],
        ].each do |next_step|
          if step?(from, next_step, reached)
            @queue << [next_step, steps + 1, reached.dup]
          end
        end
      end
    end

    def step?(f, t, reached)
      return false if t.first < 0 || t.first > 5
      return false if t.last < 0 || t.last > 5
      return false if reached[t]
      # [1, 1],
      if f.last == t.last
        # [:v, 0, 2],
        # [1, 0] -> [2, 0]
        !HWALL.include?([f, t].max)
      else
        !VWALL.include?([f, t].max)
      end
    end
  end

  def point_of(char)
    i = char.to_i(36)
    [i % 6, i / 6]
  end
end
