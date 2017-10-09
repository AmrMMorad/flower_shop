# Flower Shop
A flower shop used to base the price of their flowers on an item by item cost. So if a customer ordered 10 roses then they would be charged 10x the cost of single rose. The flower shop has decided to start selling their flowers in bundles and charging the customer on a per bundle basis. So if the shop sold roses in bundles of 5 and 10 and a customer ordered 15 they would get a bundle of 10 and a bundle of 5.

## Environment
For the environment, we need to do the following:

#### Install Ruby
Ruby can be installed [here](https://www.ruby-lang.org/en/documentation/installation/). This code is written using Ruby 2.4

#### Install RubyGem
RubyGems can be installed [here](https://rubygems.org/pages/download). RubyGems is a package management framework for Ruby

#### Install bundler
The following command used to install bundler: 
	
	gem install bundler

Bundler is used to provide a consistent environment for Ruby projects. It tracks and installs the needed gems and versions.

## Installation instructions
First, we need to install the required gems by:

    bundle install

## Testing instructions
RSpec is used for testing. Run the following command to test the application

    rspec spec

All test should be green.

## Usage instructions
We need to pass 2 parameters to the program in order to work as follows:
1. Json file for flower items that we are having in the shop.
2. Text file representing the customer order

Then use the following command:

    ruby test.rb data/flower_products.json data/input_data.txt

# For the Input file of:

    [
	  {
	    "name" : "Roses",
	    "code" : "R12",
	    "bundles": [
	      {
	        "number_of_flowers": 5,
	        "price": 6.99
	      },
	      {
	        "number_of_flowers": 10,
	        "price": 12.99
	      }
	    ]
	  },
	  {
	    "name" : "Lilies",
	    "code" : "L09",
	    "bundles": [
	      {
	        "number_of_flowers": 3,
	        "price": 9.95
	      },
	      {
	        "number_of_flowers": 6,
	        "price": 16.95
	      },
	      {
	        "number_of_flowers": 9,
	        "price": 24.95
	      }
	    ]
	  },
	  {
	    "name" : "Tulips",
	    "code" : "T58",
	    "bundles": [
	      {
	        "number_of_flowers": 3,
	        "price": 5.95
	      },
	      {
	        "number_of_flowers": 5,
	        "price": 9.95
	      },
	      {
	        "number_of_flowers": 9,
	        "price": 16.99
	      }
	    ]
	  }
	]


and the order text file is:

    10 R12
    15 L09
    13 T58
    
The output will be:

	10 R12 $12.99
	   10 X 1 $12.99
	15 L09 $41.9
	   9 X 1 $24.95
	   6 X 1 $16.95
	13 T58 $25.85
	   5 X 2 $9.95
	   3 X 1 $5.95