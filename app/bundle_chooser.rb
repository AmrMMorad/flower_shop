class BundleChooser
  
  def initialize
    @combinations = []
  end
  
  def choose_min_bundles(requested_flowers, bundles)
    return {} if requested_flowers.zero? || bundles.empty?
    get_min_bundles requested_flowers, bundles
  end
  
  private
  
  def get_min_bundles(requested_flowers, bundles)
    get_possible_bundles requested_flowers, bundles
    get_correct_bundle
  end
  
  def get_possible_bundles(requested_flowers, bundles, bundle = {})
    if requested_flowers.zero?
      @combinations << bundle
      return
    end
    
    return if requested_flowers < bundles.last.number_of_flowers
    
    bundles.each do |bund|
      next if requested_flowers - bund.number_of_flowers < 0
      get_possible_bundles requested_flowers - bund.number_of_flowers,
                           bundles,
                           adjust_bundle(bundle, bund.number_of_flowers) 
    end
  end
  
  def adjust_bundle(bundle, no_of_flowers)
    copied_bundle = bundle.clone
    copied_bundle[no_of_flowers] = copied_bundle.keys.include?(no_of_flowers) ? copied_bundle[no_of_flowers] + 1 : 1
    copied_bundle
  end
  
  def get_correct_bundle
    return {} if @combinations.empty?
    sort_bundles.first
  end
  
  def sort_bundles
    @combinations.sort_by { |combination| get_bundle_summation(combination) }
  end
  
  def get_bundle_summation(combination)
    combination.values.inject(0, :+)
  end
  
end