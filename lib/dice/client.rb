module Dice
  class Client

    attr_reader :dices_count, :value

    def probability(*args)
      parse_args(*args)
      Combination.probability(@value, @dices_count)
    end

    private

    def parse_args(*args)
      raise ArgumentError, "wrong number of arguments (2 expected but #{args.size} given)" if args.size != 2
      @value, @dices_count = args.map { |x| Integer(x.to_s) }
      raise ArgumentError, "arguments should be integer non-negative numbers" if @dices_count < 0 || @value < 0
    end
  end
end

