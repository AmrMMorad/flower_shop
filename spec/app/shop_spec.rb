require 'spec_helper'

describe Shop do
  let(:flowers) do
    [
      {
        name: 'Roses',
        code: 'R12',
        bundles: [
          { number_of_flowers: 5, price: 6.99 },
          { number_of_flowers: 10, price: 12.99 }
        ]
      },
      {
        name: 'Lilies',
        code: 'L09',
        bundles: [
          { number_of_flowers: 3, price: 9.95 },
          { number_of_flowers: 6, price: 16.95 },
          { number_of_flowers: 9, price: 24.95 }
        ]
      },
      {
        name: 'Tulips',
        code: 'T58',
        bundles: [
          { number_of_flowers: 3, price: 5.95 },
          { number_of_flowers: 5, price: 9.95 },
          { number_of_flowers: 9, price: 16.99 }
        ]
      }
    ]
  end
  let(:shop) { Shop.new(flowers) }

  context 'when order has negative flower number' do
    let(:order) { [{ code: 'T58', number_of_flowers: -1 }] }

    it 'should raise an error' do
      expect { shop.order(order) }.to raise_error(ArgumentError)
    end
  end

  context 'when order has empty code' do
    let(:order) { [{ code: '', number_of_flowers: 5 }] }

    it 'should raise an error' do
      expect { shop.order(order) }.to raise_error(ArgumentError)
    end
  end

  context 'when the order items are valid' do
    let(:order) do
      [
        { number_of_flowers: 10, code: 'R12' },
        { number_of_flowers: 15, code: 'L09' },
        { number_of_flowers: 13, code: 'T58' }
      ]
    end

    let(:result) do
      [
        {
          flower_code: 'R12',
          requested_flower: 10,
          order_bundles: [{ number_of_flowers: 10, number_needed: 1, price: 12.99 }],
          total_price: 12.99
        },
        {
          flower_code: 'L09',
          requested_flower: 15,
          order_bundles: [
            { number_of_flowers: 9, number_needed: 1, price: 24.95 },
            { number_of_flowers: 6, number_needed: 1, price: 16.95 }
          ],
          total_price: 41.90
        },
        {
          flower_code: 'T58',
          requested_flower: 13,
          order_bundles: [
            { number_of_flowers: 5, number_needed: 2, price: 9.95 },
            { number_of_flowers: 3, number_needed: 1, price: 5.95 }
          ],
          total_price: 25.85
        }
      ]
    end

    it 'should have valid output' do
      expect(shop.order(order)).to eq result
    end

  end
end
