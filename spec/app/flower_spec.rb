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
      let(:flower) { Flower.new(name: 'Lilies', code: 'R12', bundles: bundles) }

      it 'has a name' do
        expect(flower.name).to eq 'Lilies'
      end

      it 'has a code' do
        expect(flower.code).to eq 'R12'
      end

      it 'has bundles' do
        expect(flower.bundles).to eq bundles
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
        expect { Flower.new(name: '', code: 'R12', bundles: bundles).to raise_error(ArgumentError) }
      end

      it 'raises an error when entering empty name' do
        expect { Flower.new(name: 'Lilies', code: '', bundles: bundles).to raise_error(ArgumentError) }
      end
    end
  end
end
