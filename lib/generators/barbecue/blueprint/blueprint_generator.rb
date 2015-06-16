require 'barbecue'
require_relative '../generator_helpers'
require 'generators/ember/generator_helpers'

class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :filename, type: :string

  include Ember::Generators::GeneratorHelpers
  include Barbecue::GeneratorHelpers
  
  def create_models
    @blueprint = Barbecue::Dsl.blueprint(File.read(filename),filename: filename)
    @blueprint.build!(self)
  end

  def create_menu
    template "_menu.emblem", templates_path("partials/_menu.emblem")
  end
  
  private

  def class_path
    ''
  end
  
end
