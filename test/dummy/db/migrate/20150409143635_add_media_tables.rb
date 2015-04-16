class AddMediaTables < ActiveRecord::Migration
  def change
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
    end

    # create_table :media_placements, force: :cascade do |t|
    #   t.integer  :position
    #   t.integer  :owner_id
    #   t.integer  :owner_type
    #   t.integer  :media_item_id
    #   t.integer  :cover_columns, limit: 2
    #   t.string   :title_cs
    #   t.string   :title_en
    #   t.timestamps null: false      
    # end
  end
end
