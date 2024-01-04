require 'rspec'
require_relative '../../services/price_calculator'
require_relative '../../class/car'
require_relative '../../class/rental'

RSpec.describe Services::PriceCalculator do
  let(:car) { Car.new(1, 2000, 10) } 

  describe "#calculate" do
    context "with various rental durations and distances" do
      it "calculates the correct price for a short rental" do
        rental = Rental.new(1, car, '2021-01-01', '2021-01-01', 100) # 1 jour, 100 km
        calculator = Services::PriceCalculator.new(rental, car)
        expected_price_for_days = 2000 # prix pour 1 jour
        expected_price_for_distance = 100 * 10 # prix pour 100 km
        expected_total_price = expected_price_for_days + expected_price_for_distance
        expect(calculator.calculate).to eq(expected_total_price), "Expected #{expected_total_price}, but got #{calculator.calculate}"
      end
      
      it "calculates the correct price for a medium rental" do
        rental = Rental.new(1, car, '2021-01-01', '2021-01-03', 300) # 3 jours, 300 km
        calculator = Services::PriceCalculator.new(rental, car)
        expected_price_for_days = 2000 + (2000 * 0.9).to_i * 2 # 5600
        expected_price_for_distance = 300 * 10 # 3000
        expected_total_price = expected_price_for_days + expected_price_for_distance # 8600
        expect(calculator.calculate).to eq(expected_total_price), "Expected #{expected_total_price}, but got #{calculator.calculate}"
      end
      
      it "calculates the correct price for a long rental" do
        rental = Rental.new(1, car, '2021-01-01', '2021-01-10', 500) # 10 jours, 500 km
        calculator = Services::PriceCalculator.new(rental, car)
        expected_price_for_days = 2000 + (2000 * 0.9).to_i * 3 + (2000 * 0.7).to_i * 6 # Prix dégressif
        expected_price_for_distance = 500 * 10
        expected_total_price = expected_price_for_days + expected_price_for_distance
        expect(calculator.calculate).to eq(expected_total_price), "Expected #{expected_total_price}, but got #{calculator.calculate}"
      end
      
      it "calculates the correct price for a very long rental" do
        rental = Rental.new(1, car, '2021-01-01', '2021-01-20', 1000) # 20 jours, 1000 km
        calculator = Services::PriceCalculator.new(rental, car)
        expected_price_for_days = 2000 + (2000 * 0.9).to_i * 3 + (2000 * 0.7).to_i * 6 + (2000 * 0.5).to_i * 10 # Prix dégressif
        expected_price_for_distance = 1000 * 10
        expected_total_price = expected_price_for_days + expected_price_for_distance
        expect(calculator.calculate).to eq(expected_total_price), "Expected #{expected_total_price}, but got #{calculator.calculate}"
      end      
    end
  end
end