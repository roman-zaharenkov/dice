require "bigdecimal"

module Dice

  FACES_COUNT = 6

  class Combination

    @@combinations = []

    def self.total_count(dices_count)
      FACES_COUNT ** dices_count
    end

    def self.count(value, dices_count)
      return 0 if value <= 0 || dices_count <= 0
      if dices_count == 1
        return value <= FACES_COUNT ? 1 : 0
      end
      @@combinations[dices_count] ||= []
      unless @@combinations[dices_count][value]
        @@combinations[dices_count][value] = count(value - 1, dices_count) +
                                             count(value - 1, dices_count - 1) -
                                             count(value - FACES_COUNT - 1, dices_count - 1)
      end
      @@combinations[dices_count][value]
    end

    def self.probability(value, dices_count)
      BigDecimal(count(value, dices_count).to_s) / total_count(dices_count)
    end
  end
end

