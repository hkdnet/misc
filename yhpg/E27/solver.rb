class Solver
  Card = Struct.new(:suit, :rank)

  def solve(input)
    @input = input
    @cards = input.split(",").map do |card|
      suit = card[0].ord - 'A'.ord
      rank = card[1].ord - '0'.ord
      Card.new(suit, rank)
    end

    return '49' if _solve([8], @cards)
    return '26' if _solve([6, 2], @cards)
    return '20' if _solve([5, 3], @cards)
    return '18' if _solve([4, 4], @cards)
    return '11' if _solve([4, 2, 2], @cards)
    return '9' if _solve([3, 3, 2], @cards)
    return '4' if _solve([2, 2, 2, 2], @cards)

    '-'
  end

  private

  def sequence_of(n, cards)
    ranks = cards.group_by(&:rank).flat_map do |_, cs|
      cs.sort_by(&:suit).each_cons(n).select do |t|
        t.each_cons(2).all? { |a, b| a.suit + 1 == b.suit }
      end
    end
    suits = cards.group_by(&:suit).flat_map do |_, cs|
      cs.sort_by(&:rank).each_cons(n).select do |t|
        t.each_cons(2).all? { |a, b| a.rank + 1 == b.rank }
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
