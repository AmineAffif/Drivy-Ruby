module Services
  class OptionPriceCalculator
    def initialize(options, duration)
      unless duration.is_a?(Integer) && duration > 0
        raise ArgumentError, "Duration must be over 0."
      end
      
      @options = options
      @duration = duration
    end

    def calculate
      @options.sum { |option| option.price_per_day * @duration }.to_i
    end

    def calculate_for_owner
      @options.select { |option| ["gps", "baby_seat"].include?(option.type) }
              .sum { |option| option.price_per_day * @duration }.to_i
    end

    def calculate_for_drivy
      @options.select { |option| option.type == "additional_insurance" }
              .sum { |option| option.price_per_day * @duration }.to_i
    end
  end
end
