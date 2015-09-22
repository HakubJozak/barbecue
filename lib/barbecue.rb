require_relative "barbecue/version"
require_relative "barbecue/engine"
require_relative "barbecue/controller"
require_relative "barbecue/thumbnails"

require_relative "barbecue/generators"
require_relative "barbecue/generators/generated_attribute"
require_relative "barbecue/generators/plain_attribute"
require_relative "barbecue/generators/string_attribute"
require_relative "barbecue/generators/image_attribute"
require_relative "barbecue/generators/images_attribute"

require_relative "barbecue/blueprint"
require_relative 'barbecue/blueprint/attribute'
require_relative 'barbecue/blueprint/model'
require_relative 'barbecue/blueprint/builder'



module Barbecue
  mattr_accessor :parent_controller
  @@parent_controller = "Admin::BaseController"
end
