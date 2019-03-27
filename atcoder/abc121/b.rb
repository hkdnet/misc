def read_i
  gets.chomp.split(' ').map(&:to_i)
end

n, m, c = read_i
bs = read_i
ass = n.times.map { read_i }

count = 0
ass.each do |as|
  total = as.zip(bs).reduce(c) do |acc, (a, b)|
    acc + a * b
  end
  count += 1 if total > 0
end

puts count

__END__
2 3 -10
1 2 3
3 2 1
1 2 2
