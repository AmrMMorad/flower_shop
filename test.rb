require './lib/boot'
require 'json'

class Test
  class << self
    def test(args)
      flowers_json = JSON.parse(File.read(args[0]), symbolize_names: true)
      order = read_customer_order_file(args[1])
      orders = Shop.new(flowers_json).order(order)
      format_output orders
    rescue => e
      puts "There were an error happened "
      raise e
    end
  
    def read_customer_order_file(file)
      hash = []
      File.open(file) do |f|
        f.each do |line|
          number_of_flowers, code = line.chomp.split(" ")
          hash << { number_of_flowers: number_of_flowers.to_i, code: code }
        end
      end
      hash
    rescue
      abort("Invalid order file #{file}")
    end
  
    def format_output(orders)
      orders.each do |order_item|
        puts "#{order_item[:requested_flower]} #{order_item[:flower_code]} $#{order_item[:total_price]}"
        order_item[:order_bundles].each do |bundle|
          puts "   #{bundle[:number_of_flowers]} X #{bundle[:number_needed]} $#{bundle[:price]}"
        end
      end
    end
  end
end

Test.test ARGV