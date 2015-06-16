require 'rails/generators/rails/app/app_generator'
require 'pry'


module Barbecue::Dsl

  def self.blueprint(definition = nil, opts = {}, &block)
    builder = BlueprintBuilder.new

    if definition
      builder.instance_eval(definition,opts[:filename])
    elsif block_given?
      builder.instance_eval(&block)
    else
      raise 'You have to supply either definition string or a block with blueprint commands.'
    end

    builder
  end

  class BlueprintBuilder
    attr_reader :models
    
    def initialize
      @models = []
    end

    def uses(feature)
      case feature
      when :media_placements
        # TODO
      when :media_items
        # TODO
        # @generator.invoke 'barbecue:media_items_migration'
      when :menu_items        
        # TODO
      else
        raise "Unknown feature '#{feature}'"
      end
    end

    def model(name,&block)
      m = ModelBuilder.new(name)
      m.instance_eval(&block) if block_given?
      @models << m
      m
    end

    def build!(generator)
      @models.each do |model|
        model.build!(generator)
      end
    end
  end

  private

  class ModelBuilder

    attr_reader :name

    class Attribute < Struct.new(:name,:type,:options)

      def for_backend
        to_args(type)
      end

      private
      
      def to_args(typename)
        if options[:translated]
          I18n.available_locales.map {|locale| "#{name}_#{locale}:#{typename}" }
        else
          [ "#{name}:#{typename}" ]
        end
      end
    end
    
    def initialize(name)
      @name = name
      @attributes = []
    end

    def human_name
      @name.to_s.humanize.capitalize      
    end

    [ 'text','string','datetime','integer'].each do |type|
      define_method type do |name,options = {}|
        @attributes << Attribute.new(name,type,options)
      end
    end

    def build!(generator)
      @generator = generator
      attributes = @attributes.join(' ')
      opts = { behavior: generator.behavior }
      opts.merge!(generator.options)
      
      generator.with_padding do
        say! "Model"
        Rails::Generators.invoke 'model', [ @name.to_s, @attributes.map(&:for_backend) ].flatten, opts

        say! "Admin Backend"
        Rails::Generators.invoke 'barbecue:controller', [ "admin/#{@name.to_s}", @attributes.map(&:for_backend) ].flatten, opts

        say! "Admin Frontend"
        Rails::Generators.invoke 'barbecue:gui', [ @name.to_s, @attributes.map(&:for_backend) ].flatten, opts      	
      end
    end
 
    private

    def say!(msg)
      @generator.say "#{@name.to_s.capitalize} - #{msg}", output_color
    end

    def output_color
      if @generator.behavior == :invoke
        :green
      else # == :revoke
        :red
      end
    end
  end
end
