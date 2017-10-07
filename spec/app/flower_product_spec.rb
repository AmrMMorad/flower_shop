require 'spec_helper'

describe FlowerProduct do
  
  context '#new' do
    
    let(:flowers_products) do
      [
        {
          name: 'Lilies',
          code: 'R12',
          bundles: [
            {
              number_of_flowers: 5,
              price: 6.99
            },
            {
              number_of_flowers: 10,
              price: 12.99
            }
          ]
        }
      ]
    end

    
    let(:flower_products) {FlowerProduct.new(flowers_products)}

    it 'creates new flower' do
      expect(Flower).to receive(:new)
      flower_products
    end

    it 'creates two bundles' do
      expect(Bundle).to receive(:new).twice
      flower_products
    end

  end
end