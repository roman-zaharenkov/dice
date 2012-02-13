require "bigdecimal"

module Dice

  FACES_COUNT = 6

  # Performs statistic calculations of dice combinations and probability.
  class Combination

    # Creates a new instance of Combination class
    #
    def initialize
      @combinations = []
    end

    # Calculates total numbers of outcomes available when throwing specific number of dices.
    #
    # @param [Fixnum] dices_count number of dices used in experiment
    #
    # @return [Fixnum, Bignum] total numbers of outcomes
    def total_count(dices_count)
      FACES_COUNT ** dices_count
    end

    # Calculates numbers of outcomes available when throwing specific value and number of dices.
    #
    # @note: Recurrence relation is used in order to calculate value:
    # count(v, n) = count(v - 1, n - 1) + count(v - 2, n - 1) + ... count(v - 6, n - 1),
    # count(v - 1, n) = count(v - 2, n - 1) + count(v - 3, n - 1) + ... count(v - 7, n - 1)
    #
    # => count(v, n) = count(v - 1, n - 1) + count(v - 1, n) - count(v - 7, n - 1).
    #
    # Computed count values is cached in @@combinations to improve performance.
    #
    # @param [Fixnum] value target value
    # @param [Fixnum] dices_count number of dices used in experiment
    #
    # @return [Fixnum, Bignum] numbers of outcomes
    #
    def count(value, dices_count)
      return 0 if value <= 0 || dices_count <= 0
      if dices_count == 1
        return value <= FACES_COUNT ? 1 : 0
      end
      @combinations[dices_count] ||= []
      unless @combinations[dices_count][value]
        @combinations[dices_count][value] = count(value - 1, dices_count) +
                                             count(value - 1, dices_count - 1) -
                                             count(value - FACES_COUNT - 1, dices_count - 1)
      end
      @combinations[dices_count][value]
    end

    # Calculates probability of getting specific value when throwing dices.
    #
    # @param [Fixnum] value target value
    # @param [Fixnum] dices_count number of dices used in experiment
    #
    # @return [BigDecimal] probability
    #
    def probability(value, dices_count)
      BigDecimal(count(value, dices_count).to_s) / total_count(dices_count)
    end
  end
end

