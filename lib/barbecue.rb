require "barbecue/engine"

module Barbecue
  mattr_accessor :parent_controller
  @@parent_controller = "Admin::BaseController"
end



