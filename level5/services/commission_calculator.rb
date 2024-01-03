module Services
  class CommissionCalculator
    COMMISSION_RATE = 0.3

    def initialize(price, duration)
      unless price.is_a?(Numeric) && price >= 0
        raise ArgumentError, "Price must be superior or equal to 0."
      end
      unless duration.is_a?(Integer) && duration > 0
        raise ArgumentError, "Duration must be over 0."
      end

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
