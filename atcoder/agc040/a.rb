chars = gets.chomp.chars
tmp = -1
arr = chars.each.with_index.map do |c, idx|
  if c == '<'
    if tmp > 0
      tmp += 1
    else
      i = idx
      while chars[i] == c
        i += 1
      end

      tmp = 0
    end
  else
    tmp += 1
  end

  tmp
end


arr.each do |n|
end

p arr
puts arr.sum

# chars.reduce(0) do |acc, c|
#   a = if c == '>'
#     acc + 1
#   else
#     acc - 1
#   end
#
#   if a > max
#     max = a
#   elsif a < min
#     min = a
#   end
#
#   a
# end
#
#
# diff = max - min
#
# def sum(n)
#   n * (n + 1) / 2
# end
#
# puts sum(diff)
