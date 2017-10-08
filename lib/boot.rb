%w[. ../app].each do |source_dir|
  $LOAD_PATH.unshift File.expand_path(source_dir, File.dirname(__FILE__))
end

require 'bundle'
require 'flower'
require 'flower_product'
require 'bundle_chooser'
require 'customer_order'