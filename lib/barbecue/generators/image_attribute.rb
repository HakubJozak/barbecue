require_relative 'generated_attribute'


module Barbecue::Generators
  class ImageAttribute < GeneratedAttribute
    def image?
      true
    end

    def ember_data_type
      "DS.belongsTo 'image'"
    end

    def ember_field
<<FIELD
  .form-group
    label.control-label #{name.humanize}
    bbq-upload-widget owner=model attr="#{ember_name}"
    br
    img src=#{ember_name}.thumbnailUrl height='40em'      
FIELD
    end
    
    def to_permitted
      "#{name}_attributes:  image_attributes"
    end
    
    def nested_attributes?
      true
    end

    def to_rails_cli
      "#{name}_id:integer"
    end

    def code_for_model
      [ associations_code, required_code ].flatten.join("\n")
    end

    def associations_code
        <<CODE
  belongs_to :#{name}, class: Image
  accepts_nested_attributes_for :#{name}
CODE
    end


  end
end
