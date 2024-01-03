require 'json'
require_relative 'class/car'
require_relative 'class/rental'
require_relative 'class/option'
require_relative 'services/price_calculator'

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
      option_cost = Services::PriceCalculator.calculate_option_prices(rental_options, rental.duration)
      price = Services::PriceCalculator.calculate_price(rental)
      commission = Services::PriceCalculator.calculate_commission(price, rental.duration)
      payments = Services::PriceCalculator.calculate_payments(price, commission, rental.duration, rental_options)
      {
        "id" => rental.id,
        "options" => options.select { |o| o.rental_id == rental.id }.map(&:type),
        "actions" => [
          { "who" => "driver", "type" => "debit", "amount" => payments["driver"]["amount"] },
          { "who" => "owner", "type" => "credit", "amount" => payments["owner"]["amount"] },
          { "who" => "insurance", "type" => "credit", "amount" => payments["insurance"]["amount"] },
          { "who" => "assistance", "type" => "credit", "amount" => payments["assistance"]["amount"] },
          { "who" => "drivy", "type" => "credit", "amount" => payments["drivy"]["amount"] }
        ]
      }
    end
  }
end

data = read_data('data/input.json')
output = generate_output(data)

File.open('data/expected_output.json', 'w') do |file|
  file.write(JSON.pretty_generate(output))
end
