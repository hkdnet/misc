class Solver
  Card = Struct.new(:suit, :rank)

  def solve(input)
    @input = input
    @cards = input.split(",").map do |card|
      suit = card[0].ord - 'A'.ord
      rank = card[1].ord - '0'.ord
      Card.new(suit, rank)
    end

    patterns = [
      [8],
      [6, 2],
      [5, 3],
      [4, 4],
      [4, 2, 2],
      [3, 3, 2],
      [2, 2, 2, 2],
    ]

    patterns.sort_by { |e| -point(e) }.each do |pattern|
      if _solve(pattern, @cards)
        return point(pattern).to_s
      end
    end

    '-'
  end

  private

  def point(pattern)
    pattern.reduce(0) do |acc, n|
      acc + (n - 1)**2
    end
  end

  def sequence_of(n, cards)
    ranks = cards.group_by(&:rank).flat_map do |_, cs|
      cs.sort_by(&:suit).each_cons(n).select do |t|
        t.map(&:suit).tap do |tmp|
          break tmp.max - tmp.min + 1 == tmp.size
        end
      end
    end
    suits = cards.group_by(&:suit).flat_map do |_, cs|
      cs.sort_by(&:rank).each_cons(n).select do |t|
        t.map(&:rank).tap do |tmp|
          break tmp.max - tmp.min + 1 == tmp.size
        end
      end
    end
    return nil if ranks.empty? && suits.empty?
    ranks + suits
  end

  def _solve(pattern, rest)
    return true if pattern.empty?
    n, *next_pattern = pattern


    sequence_of(n, rest)&.any? do |cards|
      _solve(next_pattern, rest - cards)
    end
  end
end
