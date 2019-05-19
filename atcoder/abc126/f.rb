m, k = gets.chomp.split(' ').map(&:to_i)

def print_ans(*arr)
  puts arr.join(' ')
end

if k >= 2**m
  puts '-1'
else
  case m
  when 0
    if k == 0
      print_ans(0, 0)
    else
      puts '-1'
    end
  when 1
    if k == 0
      print_ans(0, 0, 1, 1)
    else
      puts '-1'
    end
  else
    a = (0...(2**m)).to_a
    a.delete(k)
    b = a.reverse
    print_ans(*a, k, *b, k)
  end
end
