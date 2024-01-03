require 'json'
require_relative 'class/car'
require_relative 'class/rental'
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

  { "rentals" => rentals.map do |rental|
    price = Services::PriceCalculator.calculate_price(rental)
    commission = Services::PriceCalculator.calculate_commission(price, rental.duration)
    {
      "id" => rental.id,
      "price" => price,
      "commission" => commission
    }
    end
  }
end

data = read_data('data/input.json')
output = generate_output(data)

File.open('data/expected_output.json', 'w') do |file|
  file.write(JSON.pretty_generate(output))
end
