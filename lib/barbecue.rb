require_relative "barbecue/engine"
require_relative "barbecue/generators"
require_relative "barbecue/generators/generated_attribute"
require_relative "barbecue/blueprint"
require_relative 'barbecue/blueprint/attribute'
require_relative 'barbecue/blueprint/model'
require_relative 'barbecue/blueprint/builder'
require_relative "barbecue/controller"


module Barbecue
  mattr_accessor :parent_controller
  @@parent_controller = "Admin::BaseController"
end
