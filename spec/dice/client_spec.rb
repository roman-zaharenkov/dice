require 'spec_helper'

module Dice
  describe Client do
    let(:client) { Client.new }

    describe "#probability" do
      it "sets :value and :dices_count attributes" do
        client.probability(1, 2)
        client.value.should == 1
        client.dices_count.should == 2
      end

      it "accepts string arguments" do
        client.probability('1', '2')
        client.value.should == 1
        client.dices_count.should == 2
      end

      it "calls Combination.probability" do
        Combination.should_receive(:probability).with(1, 2)
        client.probability('1', '2')
      end

      it "raises argument error for wrong number of arguments" do
        [0, 1, 3, 4].each do |number_of_arguments|
          expect {
            client.probability(*(0...number_of_arguments).to_a)
          }.to raise_error(ArgumentError, /wrong number of arguments/)
        end
      end

      it "raises argument error for negative value" do
        expect {
          client.probability(-3, 7)
        }.to raise_error(ArgumentError, /should be integer non-negative numbers/)
      end

      it "raises argument error for negative dices count" do
        expect {
          client.probability(1, -5)
        }.to raise_error(ArgumentError, /should be integer non-negative numbers/)
      end

      it "raises argument error for float value" do
        expect {
          client.probability(3.5, 7)
        }.to raise_error(ArgumentError, /invalid value for Integer/)
      end

      it "raises argument error for float dices count" do
        expect {
          client.probability(2, 4.7)
        }.to raise_error(ArgumentError, /invalid value for Integer/)
      end
    end
  end
end

