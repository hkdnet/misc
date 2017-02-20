Lake = Struct.new(:l, :r, :area)
def solve(input)
  lakes = []
  stack = []
  input.split('').each.with_index do |c, i|
    case c
    when '\\'
      stack.push(i)
    when '/'
      j = stack.pop
      next unless j
      lakes.push(Lake.new(j, i, i - j))
    end
  end
  merged = []
  lakes.sort_by { |e| [e.l, -e.r] }.each do |lake|
    last = merged.last
    next merged.push(lake) unless last
    if last.l < lake.l && last.r > lake.r
      merged[-1] = Lake.new(last.l, last.r, last.area + lake.area)
    else
      merged.push(lake)
    end
  end
  merged
end

def format_answer(lakes)
  areas = lakes.map(&:area)
  tmp = []
  tmp << (areas.inject(:+) || 0).to_s
  tmp << "#{lakes.size} #{areas.join(' ')}"
  tmp.map(&:strip).join("\n")
end

line = gets.chomp
lakes = solve(line)
puts format_answer(lakes)
