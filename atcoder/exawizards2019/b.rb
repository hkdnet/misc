gets # discard
g = gets.chomp.split('').group_by(&:itself)
puts g['R'].size > g['B'].size ? 'Yes' : 'No'
