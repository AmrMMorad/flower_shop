##
# This class contains all attributes for bundle (number of flowers
# and price) along with needed validation.
# The class als contains method for getting the bundle with prices.
class Bundle
  attr_reader :number_of_flowers, :price, :type

  def initialize(number_of_flowers:, price:, type:)
    validate_input number_of_flowers, price
    @number_of_flowers = number_of_flowers
    @price = price
    @type = type
  end

  private

  def validate_input(number_of_flowers, price)
    raise ArgumentError, 'invalid bundle parameters' unless positive_number?(number_of_flowers) &&
      positive_number?(price)
  end

  def positive_number?(number)
    number.is_a?(Numeric) && number >= 0
  end

  class << self
    def sort(bundles)
      bundles.sort_by(&:number_of_flowers).reverse
    end

    def bundle_with_prices(bundles)
      bundle_with_prices = {}
      bundles.each do |bundle|
        bundle_with_prices[bundle.number_of_flowers] = bundle.price
      end
      bundle_with_prices
    end
  end
end
