require 'rspec'
require_relative '../../services/option_price_calculator'
require_relative '../../class/option'

RSpec.describe Services::OptionPriceCalculator do
  let(:gps) { Option.new("gps", 1) }
  let(:baby_seat) { Option.new("baby_seat", 1) }
  let(:additional_insurance) { Option.new("additional_insurance", 1) }
  
  describe "#initialize" do
    context "with valid duration" do
      it "initializes successfully" do
        expect { Services::OptionPriceCalculator.new([gps], 5) }.not_to raise_error
      end
    end

    context "with invalid duration" do
      it "raises an ArgumentError" do
        expect { Services::OptionPriceCalculator.new([gps], 0) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#calculate" do
    context "with multiple options" do
      it "calculates the correct total price" do
        calculator = Services::OptionPriceCalculator.new([gps, baby_seat], 3)
        expect(calculator.calculate).to eq(2100) # 3 jours * (500 + 200)
      end
    end
  end

  describe "#calculate_for_owner" do
    context "with various options" do
      it "calculates the correct price for owner" do
        calculator = Services::OptionPriceCalculator.new([gps, baby_seat, additional_insurance], 2)
        expect(calculator.calculate_for_owner).to eq(1400) # 2 jours * (500 + 200)
      end
    end
  end

  describe "#calculate_for_drivy" do
    context "with additional insurance" do
      it "calculates the correct price for drivy" do
        calculator = Services::OptionPriceCalculator.new([additional_insurance], 4)
        expect(calculator.calculate_for_drivy).to eq(4000) # 4 jours * 1000
      end
    end
  end
end
