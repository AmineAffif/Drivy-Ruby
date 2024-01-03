module Services
  module PriceCalculator
    def self.calculate_price(rental)
      total_price_for_days = (1..rental.duration).sum do |day|
        calculate_daily_price(day, rental.car.price_per_day)
      end

      total_price_for_distance = rental.distance * rental.car.price_per_km

      (total_price_for_days + total_price_for_distance).to_i
    end
    
    private
    
    def self.calculate_daily_price(day, price_per_day)
      if day > 10
        price_per_day * 0.5
      elsif day > 4
        price_per_day * 0.7
      elsif day > 1
        price_per_day * 0.9
      else
        price_per_day
      end
    end
    
    def self.calculate_commission(price, duration)
      commission = (price * 0.3).to_i
      insurance_fee = commission / 2
      assistance_fee = duration * 100  # 1€ par jour
      drivy_fee = commission - insurance_fee - assistance_fee

      {
        insurance_fee: insurance_fee,
        assistance_fee: assistance_fee,
        drivy_fee: drivy_fee
      }
    end

    def self.calculate_payments(price, commission, duration)
      {
        "driver" => { "amount" => price },
        "owner" => { "amount" => price - commission.values.sum },
        "insurance" => { "amount" => commission[:insurance_fee] },
        "assistance" => { "amount" => commission[:assistance_fee] },
        "drivy" => { "amount" => commission[:drivy_fee] }
      }
    end
  end
end
