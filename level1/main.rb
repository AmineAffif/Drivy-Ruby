require 'json'
require 'date'

file = File.read('data/input.json')
data = JSON.parse(file)

output = { "rentals" => [] }

data['rentals'].each do |rental|
  car = data['cars'].find { |car| car['id'] == rental['car_id'] }
  price_per_day = car['price_per_day']
  price_per_km = car['price_per_km']

  start_date = Date.parse(rental['start_date'])
  end_date = Date.parse(rental['end_date'])
  duration = (end_date - start_date).to_i + 1
  distance = rental['distance']

  price = duration * price_per_day + distance * price_per_km

  output["rentals"] << { "id" => rental['id'], "price" => price }
end

File.open('data/expected_output.json', 'w') do |file|
  file.write(JSON.pretty_generate(output))
end
