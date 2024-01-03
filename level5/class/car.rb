class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(id, price_per_day, price_per_km)
    raise ArgumentError, 'ID must be an integer' unless id.is_a?(Integer)
    raise ArgumentError, 'Price per day must be a non-negative integer' unless price_per_day.is_a?(Integer) && price_per_day >= 0
    raise ArgumentError, 'Price per km must be a non-negative integer' unless price_per_km.is_a?(Integer) && price_per_km >= 0

    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end
end
