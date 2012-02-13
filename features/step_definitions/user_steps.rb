Given /^initialized dice client$/ do
  @client = Dice::Client.new
end

When /^I ask probability of getting "([^"]*)" from "([^"]*)" dices$/ do |value, dices_count|
  @probability = @client.probability(value, dices_count)
end

Then /^the probability should be close to "([^"]*)"$/ do |expected_probability|
  @probability.should be_within(1e-3).of(BigDecimal(expected_probability))
end

When /^I ask probability and pass incorrect "([^"]*)" arguments$/ do |number_of_arguments|
  begin
    @client.probability(*(0...number_of_arguments).to_a)
  rescue Exception => e
    @error = e
  end
end

When /^I ask probability of getting "([^"]*)" from "([^"]*)" dices with incorrect arguments$/ do |value, dices_count|
  begin
    @client.probability(value, dices_count)
  rescue Exception => e
    @error = e
  end
end

Then /^I should get arguments error$/ do
  @error.should be_an(ArgumentError)
end

When /^I ask probability of getting "([^"]*)" from "([^"]*)" dices "([^"]*)" times$/ do |value, dices_count, iterations|
  @mean, @standard_deviation = Benchmark.statistic(iterations.to_i) do
    @client.probability(value, dices_count)
  end
end

Then /^mean running time should not exceed "([^"]*)" seconds$/ do |expected_mean|
  @mean.should < Float(expected_mean)
end

Then /^a standard deviation should not exceed "([^"]*)" milliseconds$/ do |expected_standard_deviation|
  (@standard_deviation * 1000).should < Float(expected_standard_deviation)
end

