n, k = gets.chomp.split(' ').map(&:to_i)

ans = 0
1.upto(n).each do |i|
  # 最初に i が出た
  tmp = 1
  loop do
    if k <= i * tmp
      break
    end
    tmp *= 2
  end
  ans += 1r / n / tmp
end

printf("%.11f\n", ans)
