require "barbecue/engine"
require "barbecue/controller_commons"

module Barbecue
  mattr_accessor :parent_controller
  @@parent_controller = "Admin::BaseController"
end
