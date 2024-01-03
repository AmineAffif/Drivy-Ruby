module Services
  class PriceCalculator
    def initialize(rental, car)
      @rental = rental
      @car = car
    end

    def calculate
      (price_for_days + price_for_distance).to_i
    end

    private

    def price_for_days
      total_price = 0
      (1..@rental.duration).each do |day|
        total_price += case day
                       when 1
                         @car.price_per_day
                       when 2..4
                         (@car.price_per_day * 0.9).to_i
                       when 5..10
                         (@car.price_per_day * 0.7).to_i
                       else
                         (@car.price_per_day * 0.5).to_i
                       end
      end
      total_price
    end

    def price_for_distance
      @rental.distance * @car.price_per_km
    end
  end
end
