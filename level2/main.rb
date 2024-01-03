require 'json'
require 'date'

# Read input Data
def read_data(file_path)
  file = File.read(file_path)
  JSON.parse(file)
end

# Adjusting price_per_day if discount
def calculate_daily_price(day, price_per_day)
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

# Calculate rental price
def calculate_price(duration, price_per_day, price_per_km, distance)
  total_price_for_days = (1..duration).sum do |day|
    calculate_daily_price(day, price_per_day)
  end

  total_price_for_distance = distance * price_per_km

  (total_price_for_days + total_price_for_distance).to_i
end

# Main function
def generate_output(data)
  output = { "rentals" => [] }

  data['rentals'].each do |rental|
    car = data['cars'].find { |car| car['id'] == rental['car_id'] }
    start_date = Date.parse(rental['start_date'])
    end_date = Date.parse(rental['end_date'])
    duration = (end_date - start_date).to_i + 1
    distance = rental['distance']

    price = calculate_price(duration, car['price_per_day'], car['price_per_km'], distance)
    output["rentals"] << { "id" => rental['id'], "price" => price }
  end

  output
end

data = read_data('data/input.json')
output = generate_output(data)

File.open('data/expected_output.json', 'w') do |file|
  file.write(JSON.pretty_generate(output))
end
