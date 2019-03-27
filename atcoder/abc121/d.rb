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
  return naive(a, b) if bin1 >= bin2
  ln = naive(a, bin1 - 1)
  rn = naive(bin2, b)
  ans = ln ^ rn
  ans = ans ^ 1 if bin1 == 2
  ans
end

def ff(a, b)
  bs = []
  b.to_s(2).size.times do |rank|
    arr = [0] * 2**rank + [1] * 2**rank
    arr = arr * 2
    a_idx = a % arr.size
    b_idx = b % arr.size
    if b_idx < a_idx
      b_idx += arr.size
      arr = arr * 2
    end
    ans = 0
    arr.each_with_index do |e, idx|
      if a_idx <= idx && idx <= b_idx
        ans = ans ^ e
      end
    end
    bs << ans
  end
  bs.reverse.join('').to_i(2)
end

def fff(a, b)
  bs = b.to_s(2).size.times.map do |rank|
    period_size = 2**(rank+2)
    a_idx = a % period_size
    b_idx = b % period_size
    if b_idx < a_idx
      b_idx += period_size
    end

    # rank == 0: 01010101
    # rank == 1: 00110011
    cnt = 0
    zz_size = 2**rank
    a_idx.upto(b_idx) do |n|
      cnt += 1 if (n / zz_size) % 2 != 0
    end
    cnt % 2
  end
  bs.reverse.join('').to_i(2)
end

def check(a, b)
  a2 = ff(a, b)
  a3 = fff(a, b)
  puts "#{a2 == a3 ? :ok : :ng}: ff = #{a2} <-> fff = #{a3}"
end

check(4, 7)
check(5, 8)
check(6, 9)
check(7, 10)
check(8, 11)
a, b = read_i
puts fff(a, b)
#
# 0.upto(15).each do |e|
#   puts 'a:  %09d' % e.to_s(2)
# end
#
# 000000000
# 000000001
# 000000010
# 000000011
# 000000100
# 000000101
# 000000110 <--
# 000000111
# 000001000
# 000001001 <--
# 000001010
# 000001011
# 000001100
# 000001101
# 000001110
# 000001111
