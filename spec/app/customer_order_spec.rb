require 'spec_helper'

describe CustomerOrder do
  context '#request_order' do
    context 'low value' do
      let(:bundles) do
        [
          Bundle.new(number_of_flowers: 5, price: 6.99, type: "type1"),
          Bundle.new(number_of_flowers: 10, price: 12.99, type: "type1")
        ]
      end

      let(:flower) { Flower.new(name: 'Roses', code: 'R12', bundles: bundles) }
      let(:type) { "type1" }

      let(:subject) { CustomerOrder.new.request_order(3, flower, type).first }

      it 'has the same flower code' do
        expect(subject[:flower_code]).to eq 'R12'
      end

      it 'has the same number of flowers' do
        expect(subject[:requested_flower]).to eq 3
      end

      it 'has total price of 0' do
        expect(subject[:total_price]).to eq 0
      end

      it 'has {}' do
        expect(subject[:order_bundles]).to eq([])
      end
    end

    context 'minimum bundles' do
      let(:bundles) do
        [
          Bundle.new(number_of_flowers: 9, price: 16.99, type: "type1"),
          Bundle.new(number_of_flowers: 5, price: 9.95, type: "type1"),
          Bundle.new(number_of_flowers: 3, price: 5.95, type: "type1")
        ]
      end

      let(:flower) { Flower.new(name: 'Tulips', code: 'T58', bundles: bundles) }

      let(:customer_order_bundles) do
        [
          {
            number_of_flowers: 5,
            number_needed: 2,
            price: 9.95
          },
          {
            number_of_flowers: 3,
            number_needed: 1,
            price: 5.95
          }
        ]
      end

      let(:type) { "type1" }

      let(:subject) { CustomerOrder.new.request_order(13, flower, type).first }

      it 'has the same flower code' do
        expect(subject[:flower_code]).to eq 'T58'
      end

      it 'has the same number of flowers' do
        expect(subject[:requested_flower]).to eq 13
      end

      it 'has total price of 25.85' do
        expect(subject[:total_price]).to eq 25.85
      end

      it 'has 2 => 5 and 1 => 3' do
        expect(subject[:order_bundles]).to eq(customer_order_bundles)
      end
    end

    context 'one bundle' do
      let(:bundles) do
        [
          Bundle.new(number_of_flowers: 5, price: 6.99, type: "type1"),
          Bundle.new(number_of_flowers: 10, price: 12.99, type: "type1"),
          Bundle.new(number_of_flowers: 10, price: 5.99, type: "type2"),
          Bundle.new(number_of_flowers: 10, price: 11.99, type: "type2")
        ]
      end

      let(:flower) { Flower.new(name: 'Roses', code: 'R12', bundles: bundles) }

      let(:customer_order_bundles_type1) do
        [
          {
            number_of_flowers: 10,
            number_needed: 1,
            price: 12.99
          }
        ]
      end
      
      let(:customer_order_bundles_type2) do
        [
          {
            number_of_flowers: 10,
            number_needed: 1,
            price: 11.99
          }
        ]
      end

      let(:subject) { CustomerOrder.new.request_order(10, flower, type).first }

      context 'type1' do
        let(:type) { "type1" }
        
        it 'has the same flower code' do
          expect(subject[:flower_code]).to eq 'R12'
        end
  
        it 'has the same number of flowers' do
          expect(subject[:requested_flower]).to eq 10
        end
  
        it 'has total price of 12.99' do
          expect(subject[:total_price]).to eq 12.99
        end
  
        it 'has 1 => 10' do
          expect(subject[:order_bundles]).to eq(customer_order_bundles_type1)
        end
      end
      
      context 'type2' do
        let(:type) { "type2" }
        
        it 'has the same flower code' do
          expect(subject[:flower_code]).to eq 'R12'
        end
  
        it 'has the same number of flowers' do
          expect(subject[:requested_flower]).to eq 10
        end
  
        it 'has total price of 11.99' do
          expect(subject[:total_price]).to eq 11.99
        end
  
        it 'has 1 => 10' do
          expect(subject[:order_bundles]).to eq(customer_order_bundles_type2)
        end
      end
    end
  end
end
