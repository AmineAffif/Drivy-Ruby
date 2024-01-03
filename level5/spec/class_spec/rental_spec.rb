require_relative '../../class/rental'
require_relative '../../class/car'

RSpec.describe Rental do
  let(:car) { Car.new(1, 2000, 10) }
  subject { Rental.new(1, car, '2021-04-01', '2021-04-03', 100) }

  describe "initialization" do
    it "initializes with correct id" do
      expect(subject.id).to eq(1)
    end

    it "initializes with a Car object" do
      expect(subject.car).to be_a(Car)
    end

    it "initializes with correct start and end dates" do
      expect(subject.start_date).to eq(Date.parse('2021-04-01'))
      expect(subject.end_date).to eq(Date.parse('2021-04-03'))
    end

    it "initializes with correct distance" do
      expect(subject.distance).to eq(100)
    end
  end

  describe "duration calculation" do
    it "calculates the correct duration" do
      expect(subject.duration).to eq(3)
    end
  end

  describe "invalid initialization" do
    it "raises an error with invalid car object" do
      expect { Rental.new(1, 'not_a_car', '2021-04-01', '2021-04-03', 100) }.to raise_error(ArgumentError)
    end

    it "raises an error with invalid dates" do
      expect { Rental.new(1, car, 'invalid_date', '2021-04-03', 100) }.to raise_error(ArgumentError)
    end

    it "raises an error with negative distance" do
      expect { Rental.new(1, car, '2021-04-01', '2021-04-03', -100) }.to raise_error(ArgumentError)
    end
  end
end
