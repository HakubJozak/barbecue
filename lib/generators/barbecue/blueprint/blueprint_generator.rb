require 'barbecue'
require_relative '../generator_helpers'

class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :filename, type: :string

  include Barbecue::GeneratorHelpers
  
  def create_models
    @blueprint = Barbecue::Dsl.blueprint(File.read(filename),filename: filename)
    template "object.#{suffix}", templates_path("#{file_name}.#{suffix}")
  end

end
