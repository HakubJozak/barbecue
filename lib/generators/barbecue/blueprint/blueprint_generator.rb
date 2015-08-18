require 'barbecue'
require_relative '../generator_helpers'
require 'generators/ember/generator_helpers'

class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :filename, type: :string, default: 'db/blueprint.rb'

  class_option :menu, type: :boolean, default: true
  class_option :rebuild_db, type: :boolean, default: false

  class_option :generate_ui, type: :boolean, default: true
  class_option :generate_controller, type: :boolean, default: true
  class_option :generate_model, type: :boolean, default: true    

  include Ember::Generators::GeneratorHelpers
  include Barbecue::GeneratorHelpers

  def read_blueprint
    say "Using #{filename}"
    @blueprint = Barbecue::Blueprint.create(File.read(filename),filename: filename)
  end

  def create_media
    return unless @blueprint.enabled?(:model)
    
    if @blueprint.uses? :images
      call! 'barbecue:media', [ force_flag, migration_flag ]
    else
      say! 'Media not needed, skipping migrations'
    end
  end

  def create_models
    return unless @blueprint.enabled?(:model)

    @blueprint.models.each do |model|
        call! 'barbecue:model', [ model.name.to_s,
                                  model.attributes.to_cli,
                                  flags_for(:model),
                                  force_flag ].flatten
      end
  end

  def create_controllers
    return unless @blueprint.enabled?(:controller)

    @blueprint.models.each do |model|
        call! 'barbecue:controller',
                                 [ "admin/#{model.name}",
                                   model.attributes.to_cli,
                                   flags_for(:controller),
                                   force_flag
                                 ].flatten
    end
  end

  def create_admin
    return unless @blueprint.enabled?(:admin)
    
    @blueprint.models.each do |model|
      call! 'barbecue:gui', [ model.name.to_s,
                              model.attributes.to_cli,
                              flags_for(:admin),
                              force_flag ].flatten
    end
  end

  def create_menu
    return unless @blueprint.enabled?(:admin)

    if options[:menu]
      template "_menu.emblem", templates_path("partials/_menu.emblem")
    end
  end

  def rebuild_database
    return unless (Rails.env.development? or Rails.env.test?)
    return unless options[:rebuild_db]
    rake 'db:drop db:create db:migrate db:seed'
  end

  private

  def flags_for(generator_name)
    @blueprint.flags[generator_name].try(:split)
  end

  def class_path
    ''
  end

end
