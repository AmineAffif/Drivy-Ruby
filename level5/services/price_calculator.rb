module Services
  module PriceCalculator
    def self.calculate_price(rental)
      total_price_for_days = (1..rental.duration).sum do |day|
        calculate_daily_price(day, rental.car.price_per_day)
      end

      total_price_for_distance = rental.distance * rental.car.price_per_km

      (total_price_for_days + total_price_for_distance).to_i
    end

    def self.calculate_commission(price, duration)
      commission = (price * 0.3).to_i
      insurance_fee = commission / 2
      assistance_fee = duration * 100
      drivy_fee = commission - insurance_fee - assistance_fee

      {
        insurance_fee: insurance_fee,
        assistance_fee: assistance_fee,
        drivy_fee: drivy_fee
      }
    end

    def self.calculate_option_prices(options, duration)
      options.sum { |option| option.price_per_day * duration }
    end

    def self.calculate_payments(price, commission, duration, options)
      owner_amount = price - commission.values.sum + option_cost_for_owner(options, duration)
      drivy_amount = commission[:drivy_fee] + option_cost_for_drivy(options, duration)

      {
        "driver" => { "amount" => price + option_cost_for_driver(options, duration) },
        "owner" => { "amount" => owner_amount },
        "insurance" => { "amount" => commission[:insurance_fee] },
        "assistance" => { "amount" => commission[:assistance_fee] },
        "drivy" => { "amount" => drivy_amount }
      }
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

    def self.option_cost_for_driver(options, duration)
      options.sum { |option| option.price_per_day * duration }
    end

    def self.option_cost_for_owner(options, duration)
      options.select { |option| ["gps", "baby_seat"].include?(option.type) }
             .sum { |option| option.price_per_day * duration }
    end

    def self.option_cost_for_drivy(options, duration)
      options.select { |option| option.type == "additional_insurance" }
             .sum { |option| option.price_per_day * duration }
    end
  end
end
