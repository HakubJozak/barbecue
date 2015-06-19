require "barbecue/engine"
require "barbecue/controller_commons"
require "barbecue/blueprint"
require 'barbecue/blueprint/attribute'
require 'barbecue/blueprint/model'
require 'barbecue/blueprint/builder'
require 'barbecue/controller/commons'
require 'barbecue/controller/pagination'
require 'barbecue/controller/media'


module Barbecue
  mattr_accessor :parent_controller
  @@parent_controller = "Admin::BaseController"
end
