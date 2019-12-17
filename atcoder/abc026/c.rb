n = gets.chomp.to_i
h = Hash.new { |h, k| h[k] = [] }
(2..n).each do |e|
  b = gets.chomp.to_i
  h[b].push(e)
end

def f(h, n)
  if h[n].empty?
    1
  else
    min, max = h[n].map { |e| f(h, e) }.minmax
    min + max + 1
  end
end

puts f(h, 1)
__END__
5
1
1
1
1
