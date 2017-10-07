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
          expect { Bundle.new(number_of_flowers: 5, price: 'aaa').to raise_error(ArgumentError) }
        end
        
        it 'raises an error when entering negative number in price' do
          expect { Bundle.new(number_of_flowers: -5, price: 5).to raise_error(ArgumentError) }
        end
 
        it 'raises an error when entering negative number in price' do
          expect { Bundle.new(number_of_flowers: 5, price: -5).to raise_error(ArgumentError) }
        end
 
    end
    
  end
end