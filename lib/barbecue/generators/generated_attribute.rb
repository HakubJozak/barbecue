require 'rails/generators/generated_attribute'

module Barbecue::Generators
  class GeneratedAttribute < Rails::Generators::GeneratedAttribute
    attr_accessor :column_definition

    def self.parse(column_definition)
      parsed = super
      parsed.column_definition = column_definition
      # parse extended format like: title:string,translated
      parsed.parse_extended_options!
      binding.pry
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

    def to_rails_cli
      if type == :image
        "#{name}_id:integer"
      elsif @extended_options[:translated]
        I18n.available_locales.map do |locale|
	  "#{name}_#{locale}:string"
        end
      else
        @column_definition
      end
    end

    def required
      @extended_options[:required]
    end

    def translated
      @extended_options[:translated]
    end    
    
    def parse_extended_options!
      bits = type.to_s.split(',')
      self.type = bits.shift
      @extended_options = {}

      bits.each do |bit|
        @extended_options[bit.to_sym] = true
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
