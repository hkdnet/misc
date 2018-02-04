# 順番に引き金を引く
# ハズレた場合、弾倉を回転させる
# ただし、全員回転させかたに癖があり、常に同じ方向に同じだけ回転させる
# 残弾が 0 になるまで続ける
class Russian
  class Revolver
    attr_reader :pattern

    def initialize(pattern)
      @pattern = pattern
      @bullets = pattern.chars.map { |e| e == '1' }
      @idx = 0
      @killed = []
    end

    def shot
      bullet = @bullets[@idx]
      @bullets[@idx] = false
      bullet
    end

    def kill(player_id)
      @killed << player_id
    end

    def killed?(player_id)
      @killed.include?(player_id)
    end

    def step(num)
      @idx = (@idx + num) % @bullets.size
    end

    def done?
      @bullets.all? { |e| e == false }
    end

    def kill_all?(player_ids)
      @killed.uniq.sort == player_ids.uniq.sort
    end
  end

  Player = Struct.new(:id, :num, :killed)

  def self.parse(input)
    tmp1, tmp2 = input.split('/')
    max = tmp2.to_i
    players = []
    tmp1.chars.each.with_index do |e, i|
      if /\d/.match?(e)
        players << Player.new(i, e.to_i, tmp1[i - 1] == '[')
      end
    end
    revolver_str = (1..max).reduce([""]) do |acc, _|
      acc.flat_map { |e| [ e + '0', e + '1'] }
    end
    killed_count = players.count { |e| e.killed }
    count_matches = revolver_str.select { |str| str.chars.count { |e| e == '1' } == killed_count }
    revolvers = count_matches.map do |str|
      Revolver.new(str)
    end
    new(players: players, revolvers: revolvers)
  end

  def initialize(players:, revolvers:)
    @players = players
    @revolvers = revolvers
  end

  def exec
    killed_player_ids = @players.select(&:killed).map(&:id)
    player_idx = 0
    count = 0
    until @revolvers.all? { |e| e.done? }
      count += 1
      break if count > 10000
      @revolvers = @revolvers.select do |e|
        player = @players[player_idx]
        next true if e.killed?(player.id)
        if e.shot # 打った
          if player.killed
            # 死んだので次から飛ばす
            e.kill(player.id)
            # まわさない
            next true
          else
            # うったのに死んでないからおかしい
            next false
          end
        else
          # 生き残ったらまわす
          e.step(player.num)
        end
        true
      end
      player_idx = (player_idx + 1) % @players.size
    end
    @revolvers.select do |revolver|
      revolver.kill_all?(killed_player_ids)
    end.map(&:pattern)
  end
end
class Solver
  def solve(input)
    @input = input
    Russian.parse(input).exec
  end
end
