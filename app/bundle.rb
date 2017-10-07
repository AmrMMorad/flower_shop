class Bundle
  attr_reader :number_of_flowers, :price

  def initialize(number_of_flowers:, price:)
    validate_input number_of_flowers, price
    @number_of_flowers = number_of_flowers
    @price = price
  end
  
  private
  
  def validate_input(number_of_flowers, price)
    raise ArgumentError, "invalid bundle parameters" unless is_positive_number?(number_of_flowers) &&
      is_positive_number?(price)
  end
  
  def is_positive_number?(number)
    number.is_a?(Numeric) && number >= 0
  end

end