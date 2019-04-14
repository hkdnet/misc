_, k = gets.chomp.split(' ').map(&:to_i)
s = gets.chomp
ranges = s.chars.chunk(&:itself).map { |c, arr| [c, arr.size] }
max = if s[0] == '1'
        ranges.take(2*k + 1).map { |_, arr| arr }.reduce(:+)
      else
        ranges.take(2*k).map { |_, arr| arr }.reduce(:+)
      end
tmp = max
1.upto(ranges.size - 1) do |idx|
  c, _ = ranges[idx]
  if c == '1'
    tmp -= ranges[idx - 2][1] if idx - 2 >= 0
    tmp -= ranges[idx - 1][1]
    tmp += ranges[idx + 2*k - 1][1] if ranges[idx + 2*k - 1]
    tmp += ranges[idx + 2*k][1] if ranges[idx + 2*k]
    max = [tmp, max].max
    break if ranges[idx + 2* k].nil?
  end
end
puts max
__END__
5 1
00010
