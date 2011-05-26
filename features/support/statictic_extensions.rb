require 'benchmark'

# Adds statistic helper methods to Array class.
module ArrayExtensions

  # Calculates sum of array elements.
  def sum
    inject { |sum, x| sum + x }
  end

  # Calculates mean value of array elements.
  def mean
    sum / length
  end

  # Calculates standard deviation of array elements.
  def standard_deviation
    mean_value = mean
    Math.sqrt((inject(0) { |sum, x| sum + (x - mean_value) ** 2 }) / length)
  end
end

# Adds statistic helper methods to Benchmark module.
module BenchmarkExtensions

  # Calculates mean value and standard deviation for series of tests.
  # Realtime is used for calculations.
  #
  # @param [Fixnum] iterations number of observations
  #
  # @yield block for execution
  #
  # @return [Array] mean value and standard deviation of times used for execution block specified
  def statistic(iterations)
    observations = []
    iterations.times do
      observations << realtime do
        yield
      end
    end
    [observations.mean, observations.standard_deviation]
  end
end

Array.send :include, ArrayExtensions
Benchmark.extend(BenchmarkExtensions)

