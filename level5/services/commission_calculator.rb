module Services
  class CommissionCalculator
    COMMISSION_RATE = 0.3

    def initialize(price, duration)
      @price = price
      @duration = duration
    end

    def calculate
      total_commission = (@price * COMMISSION_RATE).to_i
      insurance_fee = (total_commission / 2).to_i
      assistance_fee = @duration * 100
      drivy_fee = (total_commission - insurance_fee - assistance_fee).to_i

      {
        insurance_fee: insurance_fee,
        assistance_fee: assistance_fee,
        drivy_fee: drivy_fee
      }
    end
  end
end
