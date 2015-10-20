require 'generators/ember/template_generator'
require_relative '../template_helpers'
require_relative '../generator_helpers'


class Barbecue::GuiGenerator < Ember::Generators::TemplateGenerator

  include Barbecue::TemplateHelpers
  include Barbecue::GeneratorHelpers

  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type ..."

  class_option :views, type: :boolean, default: true
  class_option :model, type: :boolean, default: true
  class_option :controller, type: :boolean, default: true
  class_option :serializer, type: :boolean, default: true
  class_option :routes, type: :boolean, default: true

  def create_template_files
    return unless options[:views]
    template "object.emblem", templates_path("#{file_name}.emblem")
    template "array.emblem", templates_path("#{file_name.pluralize}.emblem")
  end

  def create_routes
    return unless options[:routes]
    template 'array_route.js.coffee', routes_path("#{file_name.pluralize}_route.js.coffee")
    template 'object_route.js.coffee', routes_path("#{file_name}_route.js.coffee")
  end

  def create_controller
    return unless options[:controller]
    template 'object_controller.js.coffee', controllers_path("#{file_name}_controller.js.coffee")
  end

  def create_model
    return unless options[:model]
    template "model.js.coffee", models_path("#{file_name}.js.coffee")
  end

  def create_serializer
    return unless options[:serializer]
    template "serializer.js.coffee", serializers_path("#{file_name}_serializer.js.coffee")
  end

  def add_routes
    return unless options[:routes]
    routing  = <<-ROUTING

  @resource '#{plural}'
  @resource '#{singular}', { path: '#{plural}/:id'}
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

end
