##
# This class is used to execute the customer order
# and calculate the price of the order
class CustomerOrder
  attr_accessor :customer_order_items

  def initialize
    @customer_order_items = []
  end

  ##
  # This method is used to execute the order request
  # It mainly calls BundleChooser class to get the min
  # bundles needed for the required quantity
  def request_order(requested_flowers, flower, type)
    flower = adjust_flower_bundles flower, type
    order_min_bundles = BundleChooser.new
      .choose_min_bundles(requested_flowers, Bundle.sort(flower.bundles))
    make_order flower, requested_flowers, order_min_bundles
  end

  private
  
  def adjust_flower_bundles(flower, type)
    bundles = flower.bundles.select { |bundle| bundle.type == type }
    copied_flower = Flower.new(name: flower.name, code: flower.code, bundles: bundles)
    copied_flower
  end

  def make_order(flower, requested_flowers, order_min_bundles)
    bundles_with_prices = get_bundles_price_numbers(Bundle
      .bundle_with_prices(flower.bundles), order_min_bundles)
    @customer_order_items << {
      flower_code: flower.code,
      requested_flower: requested_flowers,
      order_bundles: bundles_with_prices,
      total_price: calculate_total_price(bundles_with_prices)
    }
  end

  def get_bundles_price_numbers(flower_bundles, order_min_bundles)
    order_min_bundles.map do |number_of_flowers, number_needed|
      {
        number_of_flowers: number_of_flowers,
        number_needed: number_needed,
        price: flower_bundles[number_of_flowers]
      }
    end
  end

  def calculate_total_price(bundles_with_prices)
    total_price = 0
    bundles_with_prices.each do |bundles_with_price|
      total_price += bundles_with_price[:number_needed] *
        bundles_with_price[:price]
    end
    total_price.round(2)
  end
end
