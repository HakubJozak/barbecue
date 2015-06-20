require_relative '../generator_helpers'
# require 'rails/generators/rails/model/model_generator'
# require 'rails/generators/active_record/model/model_generator'




#class Barbecue::ModelGenerator < Rails::Generators::ModelGenerator
# ActiveRecord::Generators::ModelGenerator
class Barbecue::ModelGenerator < Rails::Generators::NamedBase 
  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  include Barbecue::GeneratorHelpers

  class Attribute < Rails::Generators::GeneratedAttribute
    attr_accessor :column_definition

    def self.parse(column_definition)
      parsed = super
      parsed.column_definition = column_definition
      parsed
    end

    def finish(generator)
      if type == :image
        file = "app/models/#{generator.name}.rb" 
        generator.inject_into_class file, generator.name.capitalize do
          [ "  belongs_to :#{generator.name}, class: Image",
            "  accepts_nested_attributes_for :#{generator.name}\n" ].join("\n")
        end
      end
    end

    def to_cli
      if type == :image
        "#{name}_id:integer"
      else
        @column_definition
      end
    end

    # def parse_type_and_options(str)
    #   case str
    #   when /(image)\{(.+)\}/
    #   else
    #   type, options = super

    #   if type == 'image'
    #   end
    # end
  end

  def initialize(*args)
    super
    @raw_attributes = args[0][1..-1]
  end
  
  def create_model_file
    Rails::Generators.invoke 'model', [ name, attributes.map(&:to_cli),
                                        force_flag, migration_flag ].flatten, {}

    #Rails.root.join("app/models/#{name}.rb")
    attributes.each { |a| a.finish(self) }

    # template 'model.rb', File.join('app/models', class_path, "#{file_name}.rb")
  end

  private

  def parse_attributes! #:nodoc:
    self.attributes = (attributes || []).map do |attr|
      Attribute.parse(attr)
    end
  end
  

end
