require 'generators/ember/template_generator'
require_relative './template_helpers'


class Barbecue::GuiGenerator < Ember::Generators::TemplateGenerator
  # HACK: move out
  module TemplateHelpers

    def without_locale(attr)
      if translated_attribute?(attr)
        attr.name[0..-4]
      else
        attr.name
      end
    end

    def translated_attribute?(attr)
      locales = I18n.available_locales.join('|')
      attr.name =~ /.*_(#{locales})$/
    end

    def date_field(attr)
      binding = without_locale(attr).camelize(:lower)
      %{= view 'date' dateBinding='#{binding}'}
    end

    def string_field(attr,html_type = 'text')
      value = without_locale(attr).camelize(:lower)
      %{= input value=#{value} type='#{html_type}'}
    end

    def text_field(attr)
      value = without_locale(attr).camelize(:lower)
      %{= textarea value=#{value} }
    end  
    
    def input_field(attr)
      case attr.type
      when 'string' then string_field(attr)
      when 'text' then text_field(attr)
      when 'integer' then string_field(attr,'number')      
      when 'datetime' then date_field(attr)
      end
    end

    def ember_type
      case type
      when 'datetime' then 'isodate'
      when 'integer','float' then 'numeric'
      when 'text' then 'string'
      else type
      end
    end

  end


  include TemplateHelpers

  source_root File.expand_path('../templates', __FILE__)

  class_option :templates_type, desc: "Engine for Templates - 'hbs' or 'emblem'", default: 'emblem', aliases: "-t"

  argument :attributes, type: :array, default: [], banner: "field:type field:type ..."

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
