class Bundle
  attr_reader :number_of_flowers, :price

  def initialize(number_of_flowers:, price:)
    validate_input number_of_flowers, price
    @number_of_flowers = number_of_flowers
    @price = price
  end

  private

  def validate_input(number_of_flowers, price)
    raise ArgumentError, 'invalid bundle parameters' unless positive_number?(number_of_flowers) &&
      positive_number?(price)
  end

  def positive_number?(number)
    number.is_a?(Numeric) && number >= 0
  end

  # Sorting will be needed for the sake of the algorithm
  # to pick minimum number of bundles
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
