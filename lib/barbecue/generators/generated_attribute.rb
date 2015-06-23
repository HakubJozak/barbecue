require 'rails/generators/generated_attribute'

module Barbecue::Generators
  class GeneratedAttribute < Rails::Generators::GeneratedAttribute
    attr_accessor :column_definition

    def self.parse(column_definition)
      parsed = super
      parsed.column_definition = column_definition
      parsed
    end

    def append_code_for_model!(generator)
      if type == :image
        file = "app/models/#{generator.name}.rb"

        code = <<CODE
  belongs_to :#{name}, class: Image
  accepts_nested_attributes_for :#{name}
CODE

        generator.inject_into_class file, generator.name.capitalize, code
      end
    end

    def scalar?
      !image?
    end

    def image?
      (type == :image)
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
end
