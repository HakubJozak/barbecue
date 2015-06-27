require_relative 'generated_attribute'


module Barbecue::Generators
  class PlainAttribute < GeneratedAttribute
    def scalar?
      true
    end

    def to_permitted
      name.to_sym
    end

    def nested_attributes?
      false
    end
    
    def code_for_model
      required_code
    end

    def to_rails_cli
      if translated?
        I18n.available_locales.map do |locale|
	  "#{name}_#{locale}:string"
        end
      else
        # @column_definition
        "#{name}:#{type}"
      end
    end

  end
end
