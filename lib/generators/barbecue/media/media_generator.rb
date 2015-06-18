require 'rails/generators/rails/migration/migration_generator'

class Barbecue::MediaGenerator < Rails::Generators::MigrationGenerator
  source_root File.expand_path('../templates', __FILE__)

  def create_model_files
    # if behavior == :invoke
    #   rake 'barbecue:install:migrations'
    # else
    #   Rails::Generators.invoke 'migration',['media_items'], behavior: behavior
    # end
    
    template "image.rb", 'app/models/image.rb'
    generate 'migration','create_media'
    
    if behavior == :invoke
      insert_into_file migration, migration, after: /change\z/
    end
  end

  private

  def migration
<<MIGRATION
    create_table :media_items do |t|
      t.string   :title_cs
      t.string   :title_en
      t.string   :copyright_cs
      t.string   :copyright_en
      t.string   :source_url, limit: 2048
      t.string   :type, default: 'Image', null: false
      t.string   :photo_uid
      t.string   :photo_name
      t.string   :cover_url, limit: 2048
      t.text     :thumbnail_sizes, default: "--- {}\n"
      t.timestamps null: false
MIGRATION
  end
end
