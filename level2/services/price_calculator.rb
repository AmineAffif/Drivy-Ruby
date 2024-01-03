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
  end
end
