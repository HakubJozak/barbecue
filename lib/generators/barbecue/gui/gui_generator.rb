require 'generators/ember/template_generator'
require_relative '../template_helpers'
require_relative '../generator_helpers'


class Barbecue::GuiGenerator < Ember::Generators::TemplateGenerator

  include Barbecue::TemplateHelpers
  include Barbecue::GeneratorHelpers

  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type ..."

  def create_template_files
    template "object.emblem", templates_path("#{file_name}.emblem")
    template "array.emblem", templates_path("#{file_name.pluralize}.emblem")
    template 'array_route.js.coffee', routes_path("#{file_name.pluralize}_route.js.coffee")
    template 'object_route.js.coffee', routes_path("#{file_name}_route.js.coffee")
    template 'new_route.js.coffee', routes_path("#{file_name.pluralize}_new_route.js.coffee")
    template 'object_controller.js.coffee', controllers_path("#{file_name}_controller.js.coffee")
    template "model.js.coffee", models_path("#{file_name}.js.coffee")
  end

  def add_routes
    routing  = <<-ROUTING

  @resource '#{plural}', ->
    @resource '#{singular}', {path: ':#{singular}_id'}
    @route 'new'
ROUTING

    inject_into_file File.join(ember_path,'router.js.coffee'),routing,before: /\z/
  end

  protected
  
  def plural
    name.pluralize
  end

  def singular
    name
  end

  def translated_attributes
    attributes.select &self.method(:translated_attribute?)
  end

  def unique_translated_attributes
    translated_attributes.uniq { |attr| without_locale(attr) }
  end

  def translated_attribute_names
    attributes.select(&method(:translated_attribute?)).map(&method(:without_locale)).uniq
  end

  def simple_attributes
    attributes.reject &self.method(:translated_attribute?)
  end
  
end
