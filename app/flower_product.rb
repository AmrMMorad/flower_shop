##
# This class is used to read and insert
# the data from the json file
class FlowerProduct
  attr_reader :flowers_products

  def initialize(flowers_products)
    @flowers_products = flowers_products.map do |flower_product|
      insert_flower_product(flower_product)
    end
  end

  ##
  # This method is used to get the flower object from the json file
  # using the flower code
  def get_flower_by_code(code)
    @flowers_products.detect { |flower_product| flower_product.code == code }
  end

  private

  # This is used to create flower object
  def insert_flower_product(flower_product_json)
    Flower.new(
      name:    flower_product_json.fetch(:name),
      code:    flower_product_json.fetch(:code),
      bundles: get_bundles(flower_product_json.fetch(:bundles))
    )
  end

  # This method is used to get the bundles from the JSON
  def get_bundles(bundles_json)
    bundles_json.map { |bundle| insert_bundle(bundle) }
  end

  # This method is used to create new bundle
  def insert_bundle(bundle_json)
    Bundle.new(
      number_of_flowers: bundle_json.fetch(:number_of_flowers),
      price:             bundle_json.fetch(:price)
    )
  end
end
