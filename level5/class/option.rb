class Option
  attr_reader :type, :rental_id

  OPTION_PRICES = {
    "gps" => 500,
    "baby_seat" => 200,
    "additional_insurance" => 1000
  }

  def initialize(type, rental_id)
    unless OPTION_PRICES.key?(type)
      raise ArgumentError, "Invalid Option type: #{type}. Invalide types are: #{OPTION_PRICES.keys.join(', ')}"
    end

    unless rental_id.is_a?(Integer) && rental_id > 0
      raise ArgumentError, "Driver ID must be an integer over 0"
    end

    @type = type
    @rental_id = rental_id
  end

  def price_per_day
    OPTION_PRICES[type]
  end
end
