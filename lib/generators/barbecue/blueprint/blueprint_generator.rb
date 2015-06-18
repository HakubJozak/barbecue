require 'barbecue'
require_relative '../generator_helpers'
require 'generators/ember/generator_helpers'

class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :filename, type: :string

  class_option :migration, type: :boolean

  
  include Ember::Generators::GeneratorHelpers
  include Barbecue::GeneratorHelpers

  def read_blueprint
    @blueprint = Barbecue::Blueprint.create(File.read(filename),filename: filename)
  end
  
  def create_files
    @blueprint.models.each do |model|
      with_padding do
        opts = { behavior: behavior }
      
        say! "Model"
        Rails::Generators.invoke 'model', [ model.name.to_s, model.attributes.to_cli, force_flag ].flatten, opts

        say! "Admin Backend"
        Rails::Generators.invoke 'barbecue:controller',
                                 [ "admin/#{model.name}", model.attributes.to_cli, force_flag,migration_flag ].flatten, opts

        say! "Admin Frontend"
        Rails::Generators.invoke 'barbecue:gui', [ model.name.to_s, model.attributes.to_cli, force_flag ].flatten, opts
      end
    end
  end

  def create_menu
    template "_menu.emblem", templates_path("partials/_menu.emblem")
  end

  private

  def say!(msg)
    say "#{@name.to_s.capitalize} - #{msg}", output_color
  end

  def output_color
    if behavior == :invoke
      :green
    else # == :revoke
      :red
    end
  end

  def force_flag
    '--force' if options['force']
  end

  def migration_flag
    '--no-migration' unless options['migration']
  end

  def class_path
    ''
  end

end
