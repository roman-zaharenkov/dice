require 'spec_helper'

module Dice
  describe Combination do
    let(:combination) { Combination.new }

    describe "#total_count" do
      it "returns 6 ^ dices_count" do
        combination.total_count(1).should == 6
        combination.total_count(2).should == 6 * 6
        combination.total_count(3).should == 6 * 6 * 6
      end
    end

    describe "#count" do
      it "returns 0 for 0 dice" do
        (1..5).each do |dices_count|
          combination.count(0, dices_count).should == 0
        end
      end

      it "returns 0 when value < dices_count" do
        (1..5).each do |dices_count|
          (1...dices_count).each do |value|
            combination.count(value, dices_count).should == 0
          end
        end
      end

      it "returns 0 when value > 6 * dices_count" do
        (1..5).each do |dices_count|
          ((dices_count * 6 + 1)..(dices_count * 6 + 5)).each do |value|
            combination.count(value, dices_count).should == 0
          end
        end
      end

      it "returns 1 for any value from 1 dice" do
        (1..6).each do |value|
          combination.count(value, 1).should == 1
        end
      end

      it "returns correct values for 2 dices" do
        combinations_count = Array.new(13, 0)
        (1..6).each do |first|
          (1..6).each do |second|
            combinations_count[first + second] += 1
          end
        end

        combinations_count.each_with_index do |value, index|
          combination.count(index, 2).should == value
        end
      end
    end

    describe "#probability" do
      it "calls Combination.total_count once" do
        combination.should_receive(:total_count).with(5).once.and_return(6 ** 5)
        combination.probability(10, 5)
      end

      it "calls Combination.count at least once" do
        combination.should_receive(:count).at_least(:once)
        combination.probability(10, 5)
      end

      it "returns BigDecimal value" do
        combination.probability(10, 5).should be_a(BigDecimal)
      end

      it "returns count / total_count" do
        combination.should_receive(:total_count).with(2).once.and_return(6 ** 2)
        combination.should_receive(:count).with(8, 2).once.and_return(5)
        combination.probability(8, 2).should be_within(1e-3).of(BigDecimal('5') / (6 ** 2))
      end
    end
  end
end

