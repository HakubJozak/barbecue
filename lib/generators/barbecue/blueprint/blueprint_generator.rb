require 'barbecue'
require_relative '../generator_helpers'
require 'generators/ember/generator_helpers'

class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :filename, type: :string

  class_option :migration, type: :boolean
  class_option :menu, type: :boolean, default: true

  include Ember::Generators::GeneratorHelpers
  include Barbecue::GeneratorHelpers

  def read_blueprint
    @blueprint = Barbecue::Blueprint.create(File.read(filename),filename: filename)
  end

  def create_files
    @blueprint.models.each do |model|
        opts = { behavior: behavior }

        call! 'barbecue:model', [ model.name.to_s,
                                  model.attributes.to_cli,
                                  force_flag, migration_flag ].flatten, opts

        call! 'barbecue:controller',
                                 [ "admin/#{model.name}",
                                   model.attributes.to_cli,
                                   force_flag
                                 ].flatten, opts

        call! 'barbecue:gui', [ model.name.to_s,
                                model.attributes.to_cli,
                                force_flag ].flatten, opts
      end
  end

  def create_menu
    if options[:menu]
      template "_menu.emblem", templates_path("partials/_menu.emblem")
    else
      say 'Skipping menu'
    end
  end

  private
  
  def class_path
    ''
  end

end
