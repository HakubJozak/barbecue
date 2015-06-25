require 'rails/generators/generated_attribute'

module Barbecue::Generators
  class GeneratedAttribute < Rails::Generators::GeneratedAttribute
    attr_accessor :column_definition

    def initialize(*args)
      @extended_options = {}
      super
    end

    class << self
      def parse(column_definition)
        parsed = super
        parsed.column_definition = column_definition
        parsed.parse_extended_options!

        if parsed.translated? and parsed.required?
          raise ArgumentError.
                 new("Attribute '#{parsed.name}' cannot be both translated and required (not implemented).")
        end

        case parsed.type
        when :image
          replicate_with(ImageAttribute,parsed)
        when :images
          replicate_with(ImagesAttribute,parsed)
        else
          replicate_with(PlainAttribute,parsed)
        end
      end

      private

      def replicate_with(clazz,original)
        clazz.new(original.name, original.type, original.has_index?, original.attr_options)
      end
    end

    def scalar?
      false
    end
    
    def code_for(filetype)
      required_code if file == :model
    end

    def ember_name
      name.camelize(:lower)
    end

    def human_name
      name.humanize
    end

    def image?
      false
    end

    def ember_data_type
      case type
      when :datetime,:date then "DS.attr 'isodate'"
      when :integer,:decimal then "DS.attr 'number'"
      when :boolean then "DS.attr 'boolean'"
      when :text then "DS.attr 'string'"
      when :image then "DS.belongsTo 'image'"
      else "DS.attr 'string'"
      end
    end

    def to_raw
      if translated?
        I18n.available_locales.map do |locale|
	  "#{name}_#{locale}".to_sym
        end
      else
        [ name.to_sym ]
      end
    end

    def to_rails_cli
      if belongs_to?
        "#{name}_id:integer"
      elsif has_many?
        nil
      elsif translated?
        I18n.available_locales.map do |locale|
	  "#{name}_#{locale}:string"
        end
      else
        # @column_definition
        "#{name}:#{type}"
      end
    end

    def required?
      !!@extended_options[:required]
    end

    def translated?
      !!@extended_options[:translated]
    end


    def parse_extended_options!
      bits = type.to_s.split(',')
      self.type = bits.shift.to_sym
      @extended_options = {}

      bits.each do |bit|
        @extended_options[bit.to_sym] = true
      end
    end

    private

    def required_code
      if required?
        "  validates :#{name}, presence:true\n"
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
