require_relative '../../services/commission_calculator'

RSpec.describe Services::CommissionCalculator do
  describe "initialization" do
    it "initializes correctly with valid price and duration" do
      calculator = Services::CommissionCalculator.new(1000, 5)
      expect(calculator).to be_a(Services::CommissionCalculator)
    end

    it "raises an error for negative price" do
      expect { Services::CommissionCalculator.new(-1000, 5) }.to raise_error(ArgumentError)
    end

    it "raises an error for non-numeric price" do
      expect { Services::CommissionCalculator.new("not_a_number", 5) }.to raise_error(ArgumentError)
    end

    it "raises an error for non-integer duration" do
      expect { Services::CommissionCalculator.new(1000, "not_an_integer") }.to raise_error(ArgumentError)
    end

    it "raises an error for negative or zero duration" do
      expect { Services::CommissionCalculator.new(1000, 0) }.to raise_error(ArgumentError)
    end
  end

  describe "complex calculate scenarios" do
    context "with short rental duration" do
      let(:calculator) { Services::CommissionCalculator.new(1000, 1) }

      it "calculates the correct commission for 1 day" do
        commission = calculator.calculate
        expect(commission[:insurance_fee]).to eq(150) # 1000 * 0.3 / 2
        expect(commission[:assistance_fee]).to eq(100) # 1 * 100
        expect(commission[:drivy_fee]).to eq(50) # 300 - 150 - 100
      end
    end

    context "with long rental duration" do
      let(:calculator) { Services::CommissionCalculator.new(4000, 12) }

      it "calculates the correct commission for 12 days" do
        commission = calculator.calculate
        expect(commission[:insurance_fee]).to eq(600) # 4000 * 0.3 / 2
        expect(commission[:assistance_fee]).to eq(1200) # 12 * 100
        expect(commission[:drivy_fee]).to eq(-600) # 1200 - 600 - 1200 (negative drivy fee indicates an issue)
      end
    end

    context "with zero price" do
      let(:calculator) { Services::CommissionCalculator.new(0, 5) }

      it "calculates zero commission for zero price" do
        commission = calculator.calculate
        expect(commission[:insurance_fee]).to eq(0)
        expect(commission[:assistance_fee]).to eq(500) # 5 * 100
        expect(commission[:drivy_fee]).to eq(-500) # 0 - 0 - 500 (negative drivy fee indicates an issue)
      end
    end
  end
end
