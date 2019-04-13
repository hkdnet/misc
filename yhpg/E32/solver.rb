# http://nabetani.sakura.ne.jp/hena/orde32rects/

class Solver
  def solve(input)
    f = {}
    0.upto(35) do |x|
      f[x] = []
      0.upto(35) do |y|
        f[x][y] = 0
      end
    end

    @max_rank = 0
    input.split('/').each.with_index do |s, rank|
      n = 2 ** rank
      l, t, r, b = s.chars.map { |e| e.to_i(36) }
      l.upto(r - 1) do |x|
        t.upto(b - 1) do |y|
          f[x][y] += n
        end
      end
      @max_rank = rank if rank > @max_rank
    end

    normalize(f)

    areas = {}

    0.upto(35) do |x|
      0.upto(35) do |y|
        n = f[x][y]
        areas[n] ||= []
        areas[n] << [x, y]
      end
    end

    sqs = areas.each.with_object([]) do |(k, v), arr|
      l, t = v.first
      r, b = v.last
      if v.size == (b - t + 1) * (r - l + 1)
        # binding.pry if s > 200
        arr << v.size
      end
    end

    @f = f # debug
    sqs.sort.join(',')
  end

  def show
  end

  def normalize(f)
    return f

    t = {}

    0.upto(35) do |x|
      0.upto(35) do |y|
        t[y] ||= []
        t[y][x] = f[x][y]
      end
    end


    0.upto(35) do |x|
      found = []
      tmp = f[x][0]
      found << tmp
      replace = {}
      0.upto(35) do |y|
        e = f[x][y]
        if e == tmp
          next
        end

        if found.include?(e)
          @max_rank += 1
          replace[e] = 2 ** @max_rank
        else
          found << e
        end
      end
    end
  end
end
