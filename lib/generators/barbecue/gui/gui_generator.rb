require 'generators/ember/template_generator'

class Barbecue::GuiGenerator < Ember::Generators::TemplateGenerator
  source_root File.expand_path('../templates', __FILE__)

  class_option :templates_type, desc: "Engine for Templates - 'hbs' or 'emblem'", default: 'emblem', aliases: "-t"

  argument :attributes, type: :array, default: [], banner: "field field ..."

  def create_template_files
    suffix = options[:templates_type]

    template "object.#{suffix}", templates_path("#{file_name}.#{suffix}")
    template "array.#{suffix}", templates_path("#{file_name.pluralize}.#{suffix}")
    template 'array_route.js.coffee', routes_path("#{file_name.pluralize}_route.js.coffee")
    template 'object_route.js.coffee', routes_path("#{file_name}_route.js.coffee")
    template 'new_route.js.coffee', routes_path("#{file_name.pluralize}_new_route.js.coffee")
    template 'object_controller.js.coffee', controllers_path("#{file_name}_controller.js.coffee")
    template "model.js.coffee", models_path("#{file_name}.js.coffee")
  end

  def plural
    name.pluralize
  end

  def singular
    name
  end

  private

  def templates_path(filename)
    File.join(ember_path, 'templates', class_path, filename)
  end

  def routes_path(filename)
    File.join(ember_path, 'routes', class_path, filename)
  end

  def models_path(filename)
    File.join(ember_path, 'models', class_path, filename)
  end

  def controllers_path(filename)
    File.join(ember_path, 'controllers', class_path, filename)
  end
  
end
