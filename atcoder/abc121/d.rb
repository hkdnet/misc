def read_i
  gets.chomp.split(' ').map(&:to_i)
end

def from_zero(n)
  if n % 2 == 0
    (n / 2 % 2) ^ n
  else
    (((n + 1) / 2) % 2)
  end
end

def f(a, b)
  from_zero(a-1) ^ from_zero(b)
end

def naive(a, b)
  tmp = a
  ans = a
  loop do
    tmp += 1
    return ans if tmp > b
    ans = ans ^ tmp
  end
end

def check(a, b)
  a1 = naive(a, b)
  a2 = f(a, b)
  puts "#{a1 == a2 ? :ok : :ng}: naive(#{a}, #{b}) = #{a1} <-> f = #{a2}"
  if a1 != a2
    a.upto(b) do |n|
      puts "%4s" % n.to_s(2)
    end
    raise
  end
end

# 1.upto(10) do|a|
#   1.upto(10) do |d|
#     b = a + d
#     check(a, b)
#   end
# end

a, b = read_i
puts f(a, b)
