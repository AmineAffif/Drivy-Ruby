require 'date'

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance, :options

  def initialize(id, car, start_date, end_date, distance, options = [])
    raise ArgumentError, 'Car must be a Car instance' unless car.is_a?(Car)
    raise ArgumentError, 'Distance must be a non-negative integer' unless distance.is_a?(Integer) && distance >= 0
    raise ArgumentError, 'Options must be an array' unless options.is_a?(Array)
    
    @id = id
    @car = car
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
    @options = options
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end
end
