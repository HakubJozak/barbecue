require 'rails/generators/generated_attribute'

module Barbecue::Generators
  class GeneratedAttribute < Rails::Generators::GeneratedAttribute
    attr_accessor :column_definition, :extended_options

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
        when :slug
          replicate_with(SlugAttribute,parsed)
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
        copy = clazz.new(original.name, original.type, original.has_index?, original.attr_options)
        copy.extended_options = original.extended_options.dup
        copy
      end
    end

    def ember_name
      name.camelize(:lower)
    end

    def human_name
      name.humanize
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

  end
end
