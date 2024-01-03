class Option
  attr_reader :type, :rental_id

  OPTION_PRICES = {
    "gps" => 500,
    "baby_seat" => 200,
    "additional_insurance" => 1000
  }

  def initialize(type, rental_id)
    @type = type
    @rental_id = rental_id
  end

  def price_per_day
    OPTION_PRICES[type]
  end
end
