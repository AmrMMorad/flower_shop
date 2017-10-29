require 'spec_helper'

describe Bundle do
  context '#new' do

    context 'with valid input values' do
      before do
        @bundle = Bundle.new(number_of_flowers: 10, price: 12.99, price_after_offer: 10)
      end

      it 'has a valid number of flowers' do
        expect(@bundle.number_of_flowers).to eq 10
      end

      it 'has a valid price' do
        expect(@bundle.price).to eq 12.99
      end
      
      it 'has a valid price after offer' do
        expect(@bundle.price_after_offer).to eq 10
      end
    end

    context 'with invalid input values' do
      it 'raises an error when entering invalid number of flowers' do
        expect do
          Bundle.new(number_of_flowers: 'aaa', price: 5, price_after_offer: 4)
        end.to raise_error(ArgumentError)
      end

      it 'raises an error when entering invalid price' do
        expect do
          Bundle.new(number_of_flowers: 5, price: 'aaa')
        end.to raise_error(ArgumentError)
      end

      it 'raises an error when entering negative number in price' do
        expect do
          Bundle.new(number_of_flowers: -5, price: 5)
        end.to raise_error(ArgumentError)
      end

      it 'raises an error when entering negative number in price' do
        expect do
          Bundle.new(number_of_flowers: 5, price: -5)
        end.to raise_error(ArgumentError)
      end
      
      it 'raises an error when entering negative number in price after offer' do
        expect do
          Bundle.new(number_of_flowers: 5, price: 5, price_after_offer: -4)
        end.to raise_error(ArgumentError)
      end
    end
  end

  context '#sort' do
    let(:bundle1) { Bundle.new(number_of_flowers: 10, price: 10, price_after_offer: 9) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5, price_after_offer: 4) }
    let(:bundle3) { Bundle.new(number_of_flowers: 15, price: 15, price_after_offer: 14) }

    let(:unsorted_bundles) do
      [
        bundle1,
        bundle2,
        bundle3
      ]
    end

    let(:sorted_bundles) do
      [
        bundle3,
        bundle1,
        bundle2
      ]
    end

    it 'sorts bundles by quantity asc' do
      expect(Bundle.sort(unsorted_bundles)).to eq sorted_bundles
    end
  end

  context '#bundle_with_prices' do
    let(:bundle1) { Bundle.new(number_of_flowers: 10, price: 10, price_after_offer: 9) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5, price_after_offer: 4) }
    let(:bundle3) { Bundle.new(number_of_flowers: 15, price: 15, price_after_offer: 14) }

    let(:bundles) do
      [
        bundle1,
        bundle2,
        bundle3
      ]
    end

    let(:bundle_with_prices_no_offer) do
      {
        10 => 10,
        5  => 5,
        15 => 15
      }
    end
    
    let(:bundle_with_prices_offer) do
      {
        10 => 9,
        5  => 4,
        15 => 14
      }
    end

    it 'should return bundle prices with no offer' do
      expect(Bundle.bundle_with_prices(bundles, false)).to eq bundle_with_prices_no_offer
    end
    
    it 'should return bundle prices with offer' do
      expect(Bundle.bundle_with_prices(bundles, true)).to eq bundle_with_prices_offer
    end
    
  end
end
