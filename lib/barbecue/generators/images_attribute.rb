require_relative 'generated_attribute'

module Barbecue::Generators
  class ImagesAttribute < GeneratedAttribute

    def code_for(filetype)
      if file == :model
        [ associations_code, required_code ].flatten.join("\n")
      end
    end

    def associations_code
        <<CODE
  belongs_to :#{name}, class: Image
  accepts_nested_attributes_for :#{name}
CODE
    end


  end
end
