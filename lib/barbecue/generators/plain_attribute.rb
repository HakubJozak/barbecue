require_relative 'generated_attribute'
require 'generators/barbecue/template_helpers'


module Barbecue::Generators
  class PlainAttribute < GeneratedAttribute
    include ::Barbecue::TemplateHelpers

    def ember_embedded_record
      nil
    end

    def ember_list_label(model_variable)
      "#{ model_variable }.#{ ember_name }"
    end
    
    def ember_field
      <<EMBLEM_FIELD
  view 'form-group' attr="#{name}" translated=#{translated?.to_s}
    label.control-label #{human_name}
    #{input_field(self)}
EMBLEM_FIELD
    end
    
    def ember_data_type
      case type
      when :datetime,:date then "DS.attr 'isodate'"
      when :integer,:decimal then "DS.attr 'number'"
      when :boolean then "DS.attr 'boolean'"
      when :text then "DS.attr 'string'"
      else "DS.attr 'string'"
      end
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
