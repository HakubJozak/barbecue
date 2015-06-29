require_relative '../generator_helpers'


class Barbecue::MediaGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  MIGRATION_NAME = 'barbecue_media_items'

  include Barbecue::GeneratorHelpers

  def create_model_files
    template "image.rb", 'app/models/image.rb'
    template "serializer.rb", 'app/serializers/admin/image_serializer.rb'

    ember_path = Rails.application.config.ember.ember_path || 'app/assets/javascripts'
    template "image.js.coffee", "#{ember_path}/models/image.js.coffee"
  end

  def create_migration
    # FIXME
    # return unless options[:migration]

    call! 'migration', [ MIGRATION_NAME, force_flag ]

    if behavior == :invoke
      file_name = Dir["db/migrate/*_#{MIGRATION_NAME}.rb"].first
      insert_into_file file_name, migration, after: /change\n/
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
      t.integer  :owner_id
      t.integer  :owner_type
      t.string   :photo_uid
      t.string   :photo_name
      t.string   :cover_url, limit: 2048
      t.text     :thumbnail_sizes, default: "--- {}\\n"
      t.timestamps null: false
    end
MIGRATION
  end
end
