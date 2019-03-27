def naive(a, b)
  tmp = a
  ans = a
  loop do
    tmp += 1
    return ans if tmp > b
    ans = ans ^ tmp
  end
end

def read_i
  gets.chomp.split(' ').map(&:to_i)
end

# [次の数値, xor する値, 次につかう bin]
def next_num(n, limit, bin)
  return [nil, nil, nil] if n > limit

  if n == bin
    nbin = bin * 2
    if limit >= nbin - 1
      # ショートカット
      # 2^n - 1 までは足したので次は 2^n になるはず
      return [nbin, 1, nbin]
    end
  end

  [n+1, n, bin]
end

def next_bin(n)
  bin = 1
  loop do
    return bin if bin > n
    bin *= 2
  end
end

def prev_bin(n)
  next_bin(n) / 2
end

def f(a, b)
  bin1 = next_bin(a)
  bin2 = prev_bin(b)
  puts "bin1 #{bin1}"
  puts "bin2 #{bin2}"
  return naive(a, b) if bin1 >= bin2
  ln = naive(a, bin1 - 1)
  rn = naive(bin2, b)
  puts "ln #{ln} <- naive(#{a}, #{bin1 - 1})"
  puts "rn #{rn} <- naive(#{bin2}, #{b})"
  ans = ln ^ rn
  loop do
    break if bin1 == bin2
    ans = ans^1
    bin1 *= 2

    puts "loop #{bin1} -> #{bin2}"
  end
  ans
end

def assert(a, b)
  puts "-----"
  puts "a: #{a}, b: #{b}"
  an = naive(a, b)
  af = f(a, b)
  puts "naive: #{an}, f: #{af}"
  if an != af
    raise 'mismatch'
  end
end

# # puts naive(*read_i)
puts "=="
puts naive(2, 3)
puts naive(8, 15)
puts "=="
assert(2, 3)
assert(2, 7)
assert(2, 15)

assert(1, 10000)
assert(1, 1000000)
assert(123, 456)


# ans
# a, b = read_i
# puts f(a, b)

