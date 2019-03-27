def read_i
  gets.chomp.split(' ').map(&:to_i)
end

n, m = read_i
shops = n.times.map { read_i }

ans = 0
shops.sort_by { |e| e[0] }.each do |p, c|
  if m <= c # この店で終わり
    ans += p * m
    break
  end
  m -= c
  ans += p*c
end

puts ans

__END__
2 5
4 9
2 4
