require 'date'

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance, :options

  def initialize(id, car, start_date, end_date, distance, options = [])
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
