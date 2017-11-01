##
# This class is used to choose the minimum bundles
# given the needed flowers number
class BundleChooser
  def initialize
    @combinations = []
  end

  ##
  # return empty if the requested flowers number is zero or we have
  # no bundles in the system.
  # This method calls another private function to get the min bundles
  # used to achieve the required number.
  def choose_min_bundles(requested_flowers, bundles)
    return {} if requested_flowers.zero? || bundles.empty?
    get_min_bundles requested_flowers, bundles
  end

  private

  ##
  # This is used to get the min bundles to achieve the required flowers
  # It works mainly on two steps:
  # 1. get all possible bundle permutations.
  # 2. get the correct bundle (min) from the possible bundles 
  def get_min_bundles(requested_flowers, bundles)
    get_possible_bundles requested_flowers, bundles
    correct_bundle
  end

  ##
  # This is a recursive method used to achieve the requested flower number.
  # loop on the given bundles and then subtract the requested flowers
  # from the bundle number of flowers. Recurse until either achieving 
  # zero which means a possible solution; otherwise do nothing
  def get_possible_bundles(requested_flowers, bundles, bundle = {})
    if requested_flowers.zero?
      @combinations << bundle
      return
    end

    return if requested_flowers < bundles.last.number_of_flowers

    bundles.each do |bund|
      remaining_flowers = requested_flowers - bund.number_of_flowers
      next if  bund.total.zero? || remaining_flowers < 0
      bund.total -= 1
      get_possible_bundles requested_flowers - bund.number_of_flowers,
                           bundles,
                           adjust_bundle(bundle, bund.number_of_flowers)
    end
  end

  ##
  # Adjust bundle is used to increase number of flowers by one or create
  # new one with default value of 1 for the number of flowers.
  def adjust_bundle(bundle, no_of_flowers)
    copied_bundle = bundle.clone
    copied_bundle[no_of_flowers] =
      copied_bundle.keys.include?(no_of_flowers) ? copied_bundle[no_of_flowers] + 1 : 1
    copied_bundle
  end

  ## 
  # This method is used to return empty if we have no possible solution; otherwise
  # sort the bundles and get the first one.
  def correct_bundle
    return {} if @combinations.empty?
    sort_bundles.first
  end

  # sort given the sum of the possible solution
  def sort_bundles
    @combinations.sort_by { |combination| bundle_summation(combination) }
  end

  # sum all the values of possible solution
  def bundle_summation(combination)
    combination.values.inject(0, :+)
  end
end
