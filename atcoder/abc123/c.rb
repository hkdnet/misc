n = gets.chomp.to_i
times = 5.times.map {gets.chomp.to_i}

m = times.min

wait = if n % m == 0
         n / m
       else
         (n / m) + 1
       end

puts 4 + wait
