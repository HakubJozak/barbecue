require 'rails/generators/rails/app/app_generator'

module Barbecue::Dsl
  private

  class Commander < Rails::Generators::Base
    def generate(*args)
      # FIXME just for testing!
      # super *args.concat(['-p'])
      super
    end
  end

  def self.scaffold(&block)
    commander = Commander.new
    ProjectBuilder.new(commander).instance_eval(&block) if block_given?
  end

  class ProjectBuilder
    def initialize(commander)
      @commander = commander
    end
    
    def uses(feature)
      case feature 
      when :media_placements
        # TODO
      when :media_items
        # TODO
        # @commander.generate 'barbecue:media_items_migration'
      else
        raise "Unknown feature '#{feature}'"
      end
    end

    def model(name,&block)
      m = ModelBuilder.new(name)
      m.instance_eval(&block) if block_given?
      m.generate!(@commander)
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
    
    def generate!(commander)
      attributes = @attributes.join(' ')
      commander.generate 'model',"#{@name} #{attributes}"
    end

  end
end



