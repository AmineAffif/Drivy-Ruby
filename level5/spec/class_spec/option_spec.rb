require_relative '../../class/option'

RSpec.describe Option do
  describe "initialization" do
    context "with valid parameters" do
      it "initializes correctly with type 'gps'" do
        option = Option.new("gps", 1)
        expect(option.type).to eq("gps")
        expect(option.rental_id).to eq(1)
        expect(option.price_per_day).to eq(500)
      end

      it "initializes correctly with type 'baby_seat'" do
        option = Option.new("baby_seat", 1)
        expect(option.type).to eq("baby_seat")
        expect(option.rental_id).to eq(1)
        expect(option.price_per_day).to eq(200)
      end
    end

    context "with invalid parameters" do
      it "raises an error for invalid option type" do
        expect { Option.new("invalid_type", 1) }.to raise_error(ArgumentError)
      end

      it "raises an error for negative rental_id" do
        expect { Option.new("gps", -1) }.to raise_error(ArgumentError)
      end

      it "raises an error for non-integer rental_id" do
        expect { Option.new("gps", "not_an_integer") }.to raise_error(ArgumentError)
      end
    end
  end
end
