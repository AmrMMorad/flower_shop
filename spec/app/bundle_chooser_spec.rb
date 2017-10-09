require 'spec_helper'

describe BundleChooser do
  let(:subject) { BundleChooser.new.choose_min_bundles(number_of_flowers, bundles) }

  context 'returns empty set for invalid solutions' do  
    let(:bundle1) { Bundle.new(number_of_flowers: 10, price: 10) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5) }

    let(:bundles) do
      [
        bundle1,
        bundle2
      ]
    end

    context 'produces empty set for zero quantity' do
      let(:number_of_flowers) { 0 }
      it { expect(subject).to eq({}) }
    end

    context 'produces empty set for very low quantity' do
      let(:number_of_flowers) { 3 }
      it { expect(subject).to eq({}) }
    end

    context 'returns empty set for unachieveable solution' do
      let(:number_of_flowers) { 7 }
      it { expect(subject).to eq({}) }
    end
  end

  context 'returns exactly one solution' do
    let(:bundle1) { Bundle.new(number_of_flowers: 15, price: 15) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5) }
    let(:bundles) do
      [
        bundle1,
        bundle2
      ]
    end

    context 'produces a list of one item if quantity equals to min bundle size' do
      let(:number_of_flowers) { 5 }
      it { expect(subject).to eq(5 => 1) }
    end
  end

  context 'returns minimum bundles' do
    let(:bundle1) { Bundle.new(number_of_flowers: 9, price: 9) }
    let(:bundle2) { Bundle.new(number_of_flowers: 5, price: 5) }
    let(:bundle3) { Bundle.new(number_of_flowers: 3, price: 3) }
    let(:bundles) do
      [
        bundle1,
        bundle2,
        bundle3
      ]
    end

    context 'returns 5 => 2' do
      let(:number_of_flowers) { 10 }
      it { expect(subject).to eq(5 => 2) }
    end

    context 'returns 5 => 2 and 3 => 1' do
      let(:number_of_flowers) { 13 }
      it { expect(subject).to eq(5 => 2, 3 => 1) }
    end

    context 'returns 5 => 1 and 3 => 2' do
      let(:number_of_flowers) { 11 }
      it { expect(subject).to eq({ 5 => 1, 3 => 2 }) }
    end

    context 'returns 9 => 1 and 3 => 1' do
      let(:number_of_flowers) { 12 }
      it { expect(subject).to eq(9 => 1, 3 => 1) }
    end
  end
end
