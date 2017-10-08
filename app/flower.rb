class Flower
  attr_reader :name, :code, :bundles

  def initialize(name:, code:, bundles:)
    validate_input name, code
    @name = name
    @code = code
    @bundles = bundles
  end

  private

  def validate_input(name, code)
    raise ArgumentError, "invalid flower parameters" if name.blank? && code.blank?
  end

end
