def read_i
  gets.chomp.split(' ').map(&:to_i)
end

a, b, c = read_i
puts a == b && b == c ? 'Yes' : 'No'
