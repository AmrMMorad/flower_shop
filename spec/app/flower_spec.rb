require 'spec_helper'

describe Flower do

  context '#new' do
    context 'with valid input values' do
      let(:bundles) do
        [
          instance_double(Bundle),
          instance_double(Bundle),
          instance_double(Bundle)
        ]
      end
      let(:flower) { Flower.new(name: 'Lilies', code: 'R12', bundles: bundles, price: 2) }

      it 'has a name' do
        expect(flower.name).to eq 'Lilies'
      end

      it 'has a code' do
        expect(flower.code).to eq 'R12'
      end

      it 'has bundles' do
        expect(flower.bundles).to eq bundles
      end
      
      it 'has price' do
        expect(flower.price).to eq 2
      end
    end

    context 'with invalid input values' do
      let(:bundles) do
        [
          instance_double(Bundle),
          instance_double(Bundle)
        ]
      end

      it 'raises an error when entering empty code' do
        expect { Flower.new(name: '', code: 'R12', bundles: bundles, price: 2).to raise_error(ArgumentError) }
      end
# 
      # it 'raises an error when entering empty name' do
        # expect { Flower.new(name: 'Lilies', code: '', bundles: bundles, price: 2).to 
          # raise_error(ArgumentError) }
      # end
      
      it 'raises an error when entering negative value in the price' do
        # expect { Flower.new(name: 'Lilies', code: 'R12').to  }
        # expect { Flower.new(name: 'Lilies', code: 'R12').code.to eq 'R12' }
        expect do
          Flower.new(name: 'Lilies', code: '', bundles: bundles, price: 2)
        end.to raise_error(ArgumentError)
      end
    end      
  end
end
