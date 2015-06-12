require "barbecue/engine"
require "barbecue/controller_commons"
require "barbecue/dsl"

module Barbecue
  mattr_accessor :parent_controller
  @@parent_controller = "Admin::BaseController"
end
