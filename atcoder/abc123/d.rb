def gets_i
  gets.chomp.split(' ').map(&:to_i)
end

def sum(arr)
  arr.inject(:+)
end

class C
  def initialize(xs, ys, zs)
    @xs = xs
    @ys = ys
    @zs = zs
  end

  def s(k)
    k.times.map do |kk|
      min = nil
      0.upto([@xs.size - 1, kk].min) do |xx|
        xx.upto([xx + @ys.size - 1, kk].min) do |yy|
          x = xx - 0
          y = yy - xx
          z = kk - yy
          next if z >= @zs.size
          if min.nil?
            min = point(x, y, z)
          else
            tmp = point(x, y, z)
            min = [min, tmp].min
          end
        end
      end
      if min.nil?
        require 'pry'; binding.pry
      end
      min
    end
  end

  def point(x, y, z)
    p [x, y, z]
    @xs[x] + @ys[y] + @zs[z]
  end
end

_, _, _, k = gets_i
c = C.new(gets_i.sort_by(&:-@), gets_i.sort_by(&:-@), gets_i.sort_by(&:-@))
c.s(k).each do |s|
  puts s
end

__END__
2 2 2 8
4 6
1 5
3 8
