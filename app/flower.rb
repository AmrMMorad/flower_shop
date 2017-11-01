##
# This class contains the needed parameters for the
# flower object along with needed validation
class Flower
  attr_reader :name, :code, :bundles, :price

  def initialize(name:, code:, bundles:, price:)
    validate_input name, code, price
    @name = name
    @code = code
    @bundles = bundles
    @price = price
  end

  private

  def validate_input(name, code, price)
    raise ArgumentError, 'invalid flower parameters' if
      (name.nil? || name.empty?) || (code.nil? || code.empty?) || price < 0
  end
end
