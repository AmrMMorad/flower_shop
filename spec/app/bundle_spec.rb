require 'spec_helper'

describe Bundle do
  context '#new' do

    context 'with valid input values' do
      before do
        @bundle = Bundle.new(number_of_flowers: 10, price: 12.99)
      end

      it 'has a valid number of flowers' do
        expect(@bundle.number_of_flowers).to eq 10
      end

      it 'has a valid price' do
        expect(@bundle.price).to eq 12.99
      end
    end

    context 'with invalid input values' do
      it 'raises an error when entering invalid number of flowers' do
        expect { Bundle.new(number_of_flowers: 'aaa', price: 5).to raise_error(ArgumentError) }
      end
 
      it 'raises an error when entering invalid price' do
        expect { Bundle.new(number_of_flowers: 5, price: 'aaa').to 
          raise_error(ArgumentError) }
      end
      
      it 'raises an error when entering negative number in price' do
          expect { Bundle.new(number_of_flowers: -5, price: 5).to raise_error(ArgumentError) }
        end
 
        it 'raises an error when entering negative number in price' do
        expect { Bundle.new(number_of_flowers: 5, price: -5).to raise_error(ArgumentError) }
      end
    end
  end

  context '#sort' do
    let(:bundle1) { Bundle.new(number_of_flowers: 10, price: 10) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5) }
    let(:bundle3) { Bundle.new(number_of_flowers: 15, price: 15) }

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
    let(:bundle1) { Bundle.new(number_of_flowers: 10, price: 10) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5) }
    let(:bundle3) { Bundle.new(number_of_flowers: 15, price: 15) }

    let(:bundles) do
      [
        bundle1,
        bundle2,
        bundle3
      ]
    end

    let(:bundle_with_prices) do
      {
        10 => 10,
        5  => 5,
        15 => 15
      }
    end

    it 'should return bundle prices' do
      expect(Bundle.bundle_with_prices(bundles)).to eq bundle_with_prices
    end
  end
end
