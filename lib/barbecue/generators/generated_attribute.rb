require 'rails/generators/generated_attribute'

module Barbecue::Generators
  class GeneratedAttribute < Rails::Generators::GeneratedAttribute
    attr_accessor :column_definition

    def initialize(*args)
      @extended_options = {}

      if translated? and required?
        raise ArgumentError.new("Attribute '#{name}' cannot be translated and require at once (not implemented)")
      end

      super
    end

    def self.parse(column_definition)
      parsed = super
      parsed.column_definition = column_definition
      parsed.parse_extended_options!
      parsed
    end

    def code_for_model
      if type == :image
        <<CODE
  belongs_to :#{name}, class: Image
  accepts_nested_attributes_for :#{name}
CODE
      elsif required?
        "validates :#{name}, presence:true\n"
      end
    end

    def scalar?
      !image?
    end

    def image?
      (type == :image)
    end

    def to_raw
      if translated?
        I18n.available_locales.map do |locale|
	  "#{name}_#{locale}".to_sym
        end
      else
        name.to_sym
      end
    end

    def to_rails_cli
      if image?
        "#{name}_id:integer"
      elsif translated?
        I18n.available_locales.map do |locale|
	  "#{name}_#{locale}:string"
        end
      else
        @column_definition
      end
    end

    def required?
      @extended_options[:required]
    end

    def translated?
      @extended_options[:translated]
    end    
    
    def parse_extended_options!
      bits = type.to_s.split(',')
      self.type = bits.shift.to_sym
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
