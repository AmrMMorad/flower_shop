##
# This class contains calls the customer order
# and then returns the order items
class Shop
  def initialize(flower_json, offer)
    @flower_product = FlowerProduct.new(flower_json)
    @offer = offer
  end

  def order(items)
    customer_order = CustomerOrder.new

    items.each do |item|
      flower = @flower_product.get_flower_by_code(item[:code])
      raise ArgumentError, "invalid flower code #{item[:code]}" unless
        flower && item[:number_of_flowers] > 0
      customer_order.request_order item[:number_of_flowers], flower, @offer
    end

    customer_order.customer_order_items
  end
end
