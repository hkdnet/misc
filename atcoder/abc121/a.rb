h, w = gets.chomp.split(' ').map(&:to_i)
hh, ww = gets.chomp.split(' ').map(&:to_i)

puts (h * w) - (h * ww) - (hh * w) + hh*ww
