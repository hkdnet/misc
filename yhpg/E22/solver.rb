class Solver
  def solve(input)
    @m, @n, @b, @x = input.split(',').map(&:to_i)
    arr = (@m..@n).map { |e| e.to_s(@b) }
    arr.sort[@x - 1].to_i(@b).to_s
  end
end


class Solver
  def solve(input)
    @m, @n, @b, @x = input.split(',').map(&:to_i)
    bm = @m.to_s(@b)
    bn = @n.to_s(@b)
    arr = chars.drop(1) # 0 抜く
    min_bm_rank_num = ('1' + '0' * (bm.size - 1)).to_i(@b)
    buffer = @m - min_bm_rank_num + 10 # 最後の10はてきとう
    rank = 1
    loop do
      break if arr.include?(bm)
      arr = next_arr(arr, rank)
      rank += 1
      p arr if $dbg
    end
    # 1回まわしておかないと元データが足りなかったりする……
    if rank < bn.size
      arr = next_arr(arr, rank)
      rank += 1
      puts '1回やった' if $dbg
      p arr if $dbg
    end
    puts "落とす" if $dbg
    arr.select! { |e| e.to_i(@b) >= min_bm_rank_num }
    p arr if $dbg

    while rank < bn.size
      arr = next_arr(arr, rank)
      rank += 1
      # 枝刈り
      puts "枝刈り前 #{arr}" if $dbg
      arr = arr.take(@x + buffer)
      puts "枝刈り後 #{arr}" if $dbg
    end
    binding.pry if $dbg
    arr.select! { |e| e.to_i(@b) >= @m }
    arr[@x - 1].to_i(@b).to_s
  end

  def chars
    @chars ||= (0...@b).map { |e| e.to_s(@b) }
  end

  def next_arr(arr, rank)
    ret = []
    arr.each do |e|
      ret << e
      if e.size == rank
        chars.each do |c|
          ret << e + c
        end
      end
    end
    ret # .tap { |e| raise 'error' unless e == e.sort }
  end
end
