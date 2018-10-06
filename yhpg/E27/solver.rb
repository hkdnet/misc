class Solver
  Card = Struct.new(:suit, :rank)

  def solve(input)
    @input = input
    @cards = input.split(",").map do |card|
      suit = card[0].ord - 'A'.ord
      rank = card[1].ord - '0'.ord
      Card.new(suit, rank)
    end
    return '49' if sequence?(8, @cards)

    if tmp = sequence?(6, @cards)
      tmp.each do |candidates|
        rests = @cards - candidates
        return '26' if sequence?(2, rests)
      end
    end

    if tmp = sequence?(5, @cards)
      tmp.each do |candidates|
        rests = @cards - candidates
        return '20' if sequence?(3, rests)
      end
    end

    if tmp = sequence?(4, @cards)
      tmp.each do |candidates|
        rests = @cards - candidates
        return '18' if sequence?(4, rests)
        if tmp2 = sequence?(2, rests)
          tmp2.each do |cs|
            r = rests - cs
            return '11' if sequence?(2, r)
          end
        end
      end
    end

    if tmp = sequence?(3, @cards)
      tmp.each do |candidates|
        rests = @cards - candidates
        if tmp2 = sequence?(3, rests)
          tmp2.each do |cs|
            r = rests - cs
            return '9' if sequence?(2, r)
          end
        end
      end
    end

    if tmp = sequence?(2, @cards)
      tmp.each do |candidates|
        rests = @cards - candidates
        if tmp2 = sequence?(2, rests)
          tmp2.each do |cs|
            r = rests - cs
            if tmp3 = sequence?(2, r)
              tmp3.each do |cs2|
                r2 = r - cs2
                return '4' if sequence?(2, r2)
              end
            end
          end
        end
      end
    end

    '-'
  end

  private

  def sequence?(n, cards)
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
end
