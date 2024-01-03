require 'json'
require_relative 'class/car'
require_relative 'class/rental'
require_relative 'class/option'
require_relative 'services/price_calculator'
require_relative 'services/commission_calculator'
require_relative 'services/option_price_calculator'

def read_data(file_path)
  file = File.read(file_path)
  JSON.parse(file)
end

def generate_output(data)
  cars = data['cars'].map { |car_data| Car.new(car_data['id'], car_data['price_per_day'], car_data['price_per_km']) }
  rentals = data['rentals'].map do |rental_data|
    car = cars.find { |c| c.id == rental_data['car_id'] }
    Rental.new(rental_data['id'], car, rental_data['start_date'], rental_data['end_date'], rental_data['distance'])
  end
  options = data['options'].map { |option_data| Option.new(option_data['type'], option_data['rental_id']) }

  { "rentals" => rentals.map do |rental|
      rental_options = options.select { |o| o.rental_id == rental.id }
      price_calculator = Services::PriceCalculator.new(rental, rental.car)
      option_calculator = Services::OptionPriceCalculator.new(rental_options, rental.duration)
      commission_calculator = Services::CommissionCalculator.new(price_calculator.calculate, rental.duration)

      base_price = price_calculator.calculate
      option_price = option_calculator.calculate
      total_price = base_price + option_price
      commission = commission_calculator.calculate

      owner_revenue = base_price - commission.values.sum + option_calculator.calculate_for_owner

      {
        "id" => rental.id,
        "options" => rental_options.map(&:type),
        "actions" => [
          { "who" => "driver", "type" => "debit", "amount" => total_price },
          { "who" => "owner", "type" => "credit", "amount" => owner_revenue },
          { "who" => "insurance", "type" => "credit", "amount" => commission[:insurance_fee] },
          { "who" => "assistance", "type" => "credit", "amount" => commission[:assistance_fee] },
          { "who" => "drivy", "type" => "credit", "amount" => commission[:drivy_fee] + option_calculator.calculate_for_drivy }
        ]
      }
    end
  }
end

data = read_data('data/input.json')
output = generate_output(data)

File.open('data/expected_output.json', 'w') do |file|
  json_output = JSON.pretty_generate(output)
  json_output.gsub!(/\[\s*\]/, '[]') # Remove line breaks from empty arrays
  file.write(json_output)
end
