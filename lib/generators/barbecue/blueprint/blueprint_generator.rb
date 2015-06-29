require 'barbecue'
require_relative '../generator_helpers'
require 'generators/ember/generator_helpers'

class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :filename, type: :string, default: 'db/blueprint.rb'

  class_option :migration, type: :boolean
  class_option :menu, type: :boolean, default: true
  class_option :rebuild_db, type: :boolean, default: false

  include Ember::Generators::GeneratorHelpers
  include Barbecue::GeneratorHelpers

  def read_blueprint
    say "Using #{filename}"
    @blueprint = Barbecue::Blueprint.create(File.read(filename),filename: filename)
  end

  def create_media
    if @blueprint.uses? :images
      call! 'barbecue:media', [ force_flag, migration_flag ]
    else
      say! 'Media not needed, skipping migrations'
    end
  end

  def create_files
    @blueprint.models.each do |model|
        call! 'barbecue:model', [ model.name.to_s,
                                  model.attributes.to_cli,
                                  force_flag, migration_flag ].flatten

        call! 'barbecue:controller',
                                 [ "admin/#{model.name}",
                                   model.attributes.to_cli,
                                   force_flag
                                 ].flatten

        call! 'barbecue:gui', [ model.name.to_s,
                                model.attributes.to_cli,
                                force_flag ].flatten
      end
  end

  def create_menu
    if options[:menu]
      template "_menu.emblem", templates_path("partials/_menu.emblem")
    else
      say 'Skipping menu'
    end
  end

  def rebuild_database
    return unless (Rails.env.development? or Rails.env.test?)
    return unless options[:rebuild_db]
    rake 'db:drop db:create db:migrate db:seed'
  end

  private
  
  def class_path
    ''
  end

end
