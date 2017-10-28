require 'spec_helper'

describe BundleChooser do
  let(:subject) { BundleChooser.new.choose_min_bundles(number_of_flowers, bundles, type) }

  context 'returns empty set for invalid solutions' do  
    let(:bundle1) { Bundle.new(number_of_flowers: 10, price: 10, type: :type1) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5, type: :type1) }
    let(:bundle3) { Bundle.new(number_of_flowers: 7, price: 5, type: :type2) }

    let(:bundles) do
      [
        bundle1,
        bundle2,
        bundle3
      ]
    end

    context 'produces empty set for zero quantity' do
      let(:number_of_flowers) { 0 }
      let(:type) { 'type1' }
      it { expect(subject).to eq({}) }
    end

    context 'produces empty set for very low quantity' do
      let(:number_of_flowers) { 3 }
      let(:type) { :type1 }
      it { expect(subject).to eq({}) }
    end

    context 'returns empty set for unachieveable solution' do
      let(:type) { :type1 }
      let(:number_of_flowers) { 7 }
      it { expect(subject).to eq({}) }
    end
    
    context 'returns empty set for unachieveable solution given different type' do
      let(:type) { :type1 }
      let(:number_of_flowers) { 7 }
      it { expect(subject).to eq({}) }
    end
  end

  context 'returns exactly one solution' do
    let(:bundle1) { Bundle.new(number_of_flowers: 15, price: 15, type: 'type1') }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5, type: 'type1') }
    let(:bundle3) { Bundle.new(number_of_flowers: 14, price: 14, type: 'type2') }
    let(:bundle4) { Bundle.new(number_of_flowers: 7, price: 7, type: 'type2') }
    let(:bundles) do
      [
        bundle1,
        bundle2,
        bundle3,
        bundle4
      ]
    end

    context 'produces a list of one item if quantity equals to min bundle size' do
      let(:number_of_flowers) { 5 }
      let(:type) { 'type1' }
      it { expect(subject).to eq(5 => 1) }
    end
    
    context 'produces a list of one item if quantity equals to min bundle size with type2' do
      let(:number_of_flowers) { 7 }
      let(:type) { 'type2' }
      it { expect(subject).to eq(7 => 1) }
    end
  end

  context 'returns minimum bundles' do
    let(:bundle1) { Bundle.new(number_of_flowers: 9, price: 9, type: 'type1') }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5, type: 'type1') }
    let(:bundle3) { Bundle.new(number_of_flowers: 3, price: 3, type: 'type1') }
    let(:bundle4) { Bundle.new(number_of_flowers: 5, price: 5, type: 'type2') }
    let(:bundle5) { Bundle.new(number_of_flowers: 10, price: 10, type: 'type2') }
    let(:bundle6) { Bundle.new(number_of_flowers: 15, price: 15, type: 'type2') }
    let(:bundles) do
      [
        bundle1,
        bundle2,
        bundle3,
        bundle4,
        bundle5,
        bundle6
      ]
    end

    context 'returns 5 => 2' do
      let(:number_of_flowers) { 10 }
      let(:type) { 'type1' }
      it { expect(subject).to eq(5 => 2) }
    end

    context 'returns 5 => 2 and 3 => 1' do
      let(:number_of_flowers) { 13 }
      let(:type) { 'type1' }
      it { expect(subject).to eq(5 => 2, 3 => 1) }
    end

    context 'returns 5 => 1 and 3 => 2' do
      let(:number_of_flowers) { 11 }
      let(:type) { 'type1' }
      it { expect(subject).to eq({ 5 => 1, 3 => 2 }) }
    end

    context 'returns 9 => 1 and 3 => 1' do
      let(:number_of_flowers) { 12 }
      let(:type) { 'type1' }
      it { expect(subject).to eq(9 => 1, 3 => 1) }
    end
    
    context 'returns 15 => 1, 5 => 1' do
      let(:number_of_flowers) { 20 }
      let(:type) { 'type2' }
      it { expect(subject).to eq(15 => 1, 5 => 1) }
    end
    
  end
end
