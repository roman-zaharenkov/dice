require 'benchmark'

module BenchmarkExtensions
  def statistic(iterations)
    observations = []
    iterations.times do
      observations << realtime do
        yield
      end
    end
    mean = (observations.inject(0) { |sum, x| sum + x }) / observations.length
    standard_deviation = Math.sqrt((observations.inject(0) { |sum, x| sum + (x - mean) ** 2 }) / observations.length)
    [mean, standard_deviation]
  end
end

Benchmark.extend(BenchmarkExtensions)

