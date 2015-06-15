require 'rails/generators/rails/app/app_generator'

module Barbecue::Dsl

  def self.blueprint(generator,&block)
    ProjectBuilder.new(generator).instance_eval(&block) if block_given?
  end

  private
  
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
      m.blueprint(@generator)
    end
  end

  class ModelBuilder

    def initialize(name)
      @name = name
      @attributes = []
    end

    def translated(attr)
      I18n.available_locales.each do |locale|
        self.string("#{attr}_#{locale}")
      end
    end

    [ 'string','datetime','integer'].each do |type|
      define_method type do |name|
        @attributes << "#{name}:#{type}"
      end
    end

    def blueprint(generator)
      attributes = @attributes.join(' ')
      generator.generate 'model',"#{@name} #{attributes}"
    end

  end
end
