require "barbecue/engine"
require "barbecue/controller_commons"
require "barbecue/blueprint"
require 'barbecue/blueprint/attribute'
require 'barbecue/blueprint/model'
require 'barbecue/blueprint/builder'


module Barbecue
  mattr_accessor :parent_controller
  @@parent_controller = "Admin::BaseController"
end
