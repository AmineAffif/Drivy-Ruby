require_relative '../../class/car'

RSpec.describe Car do
  subject { Car.new(1, 2000, 10) }

  describe "initialization" do
    it "initializes with correct id" do
      expect(subject.id).to eq(1)
    end

    it "initializes with correct price_per_day" do
      expect(subject.price_per_day).to eq(2000)
    end

    it "initializes with correct price_per_km" do
      expect(subject.price_per_km).to eq(10)
    end
  end

  describe "attribute types" do
    it "has an integer id" do
      expect(subject.id).to be_a(Integer)
    end

    it "has an integer price_per_day" do
      expect(subject.price_per_day).to be_a(Integer)
    end

    it "has an integer price_per_km" do
      expect(subject.price_per_km).to be_a(Integer)
    end
  end

  describe "invalid initialization" do
    it "raises an error with invalid id" do
      expect { Car.new('a', 2000, 10) }.to raise_error(ArgumentError)
    end

    it "raises an error with negative price_per_day" do
      expect { Car.new(1, -2000, 10) }.to raise_error(ArgumentError)
    end

    it "raises an error with negative price_per_km" do
      expect { Car.new(1, 2000, -10) }.to raise_error(ArgumentError)
    end
  end
end
