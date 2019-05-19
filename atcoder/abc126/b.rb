def month?(str)
  n = str.to_i
  return false if n <= 0
  return false if n > 12
  true
end

def year?(str)
  true
end

def yymm?(a, b)
  year?(a) && month?(b)
end

def mmyy?(a, b)
  yymm?(b, a)
end

s = gets.chomp

a, b = s[0, 2], s[2, 2]

if yymm?(a, b) && mmyy?(a, b)
  puts 'AMBIGUOUS'
elsif yymm?(a, b)
  puts 'YYMM'
elsif mmyy?(a, b)
  puts 'MMYY'
else
  puts 'NA'
end
