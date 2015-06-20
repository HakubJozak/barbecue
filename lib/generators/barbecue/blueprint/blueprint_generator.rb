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
        opts = { behavior: behavior }

        say! "Model"
        call! 'model', [ model.name.to_s,
                             model.attributes.to_cli,
                             force_flag, migration_flag ].flatten, opts

        say! "Admin Backend"
        call! 'barbecue:controller',
                                 [ "admin/#{model.name}",
                                   model.attributes.to_cli,
                                   force_flag
                                 ].flatten, opts

        say! "Admin Frontend"
        call! 'barbecue:gui', [ model.name.to_s,
                                model.attributes.to_cli,
                                force_flag ].flatten, opts
      end
  end

  def create_menu
    template "_menu.emblem", templates_path("partials/_menu.emblem")
  end

  private

  def call!(*args)
    with_padding do
      Rails::Generators.invoke(*args)
    end
  end

  def class_path
    ''
  end

end
