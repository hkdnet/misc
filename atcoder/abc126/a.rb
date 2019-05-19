_, n = gets.chomp.split(' ').map(&:to_i)
s = gets.chomp
n -= 1

s[n] = s[n].downcase
puts s

__END__
3 1
ABC
