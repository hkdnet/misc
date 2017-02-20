$stdin = File.open(__dir__ + '/a.input')
gets
a = gets.chomp.split(' ').map(&:to_i)
gets
b = gets.chomp.split(' ').map(&:to_i)
# puts a.count { |e| b.include?(e) }
puts a.select { |e| b.include?(e) }
