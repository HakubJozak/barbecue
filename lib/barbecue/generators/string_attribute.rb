require_relative 'plain_attribute'
require 'generators/barbecue/template_helpers'


module Barbecue::Generators
  class StringAttribute < PlainAttribute
    # TODO: add slug logic here
    include ::Barbecue::TemplateHelpers
  end
end
