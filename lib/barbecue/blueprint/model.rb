module Barbecue::Blueprint 
  class Model
    attr_reader :name, :attributes

    def initialize(name)
      @name = name
      @attributes = Attributes.new
    end

    def human_name
      @name.to_s.humanize.capitalize
    end

    [ 'text','string','datetime','integer','decimal','boolean'].each do |type|
      define_method type do |name,options = {}|
        @attributes << Attribute.new(name,type,options)
      end
    end
  end
end
