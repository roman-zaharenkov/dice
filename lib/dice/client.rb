# @author Roman Zaharenkov

module Dice

  # Helper class for user interaction.
  # Parses arguments and delegates calls to library classes.
  class Client

    attr_reader :dices_count, :value

    # Gets probability of getting exact value using specified number of dices.
    #
    # @param [Array] args should contain value and dices count
    #
    # @return [BigDecimal] probability of getting exact value using specified number of dices
    #
    # @raise [ArgumentError] if number of argument is not equal to 2
    # @raise [ArgumentError] if arguments is not non-negative integer numbers or it string representation
    #
    def probability(*args)
      parse_args(*args)
      Combination.new.probability(@value, @dices_count)
    end

    private

    def parse_args(*args)
      raise ArgumentError, "wrong number of arguments (2 expected but #{args.size} given)" if args.size != 2
      @value, @dices_count = args.map { |x| Integer(x.to_s) }
      raise ArgumentError, "arguments should be integer non-negative numbers" if @dices_count < 0 || @value < 0
    end
  end
end

