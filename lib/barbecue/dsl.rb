require 'rails/generators/rails/app/app_generator'
require 'pry'


module Barbecue::Dsl

  def self.blueprint(generator, definition = nil, opts = {}, &block)
    builder = ProjectBuilder.new(generator)

    if definition
      builder.instance_eval(definition,opts[:filename])
    elsif block_given?
      builder.instance_eval(&block)
    else
      raise 'You have to supply either definition string or a block with blueprint commands.'
    end
  end

  class ProjectBuilder
    def initialize(generator)
      @generator = generator
    end

    def uses(feature)
      case feature
      when :media_placements
        # TODO
      when :media_items
        # TODO
        # @generator.generate 'barbecue:media_items_migration'
      else
        raise "Unknown feature '#{feature}'"
      end
    end

    def model(name,&block)
      m = ModelBuilder.new(name)
      m.instance_eval(&block) if block_given?
      m.invoke(@generator)
    end
  end

  private

  class ModelBuilder

    class Attribute < Struct.new(:name,:type,:options)
      def for_model
        if options[:translated]
          I18n.available_locales.map {|locale| "#{name}_#{locale}:#{type}" }
        else
          [ "#{name}:#{type}" ]
        end
      end

      def for_controller
        for_model
      end

      def for_gui
        []
      end
    end
    
    def initialize(name)
      @name = name
      @attributes = []
    end

    [ 'text','string','datetime','integer'].each do |type|
      define_method type do |name,options = {}|
        @attributes << Attribute.new(name,type,options)
      end
    end

    def invoke(generator)
      attributes = @attributes.join(' ')
      generator.invoke 'model', [ @name.to_s, @attributes.map(&:for_model) ].flatten
      generator.invoke 'barbecue:controller', [ "admin/#{@name.to_s}", @attributes.map(&:for_controller) ].flatten      
    end
    
  end
end
