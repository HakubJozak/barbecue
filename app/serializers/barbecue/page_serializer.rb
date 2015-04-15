class Barbecue::PageSerializer < ActiveModel::Serializer
  attributes :id, :title_en, :url_en, :perex_en, :meta_title_en, :meta_description_en,
             :title_cs, :url_cs, :perex_cs, :meta_title_cs, :meta_description_cs,
             :year, :text_content_en, :text_content_cs, :subtitle_cs, :subtitle_en, :updated_at, :created_at,
             :published_at, :featured, :cover_type, :cover_columns, :media_placements_count, :links_count,
             :igram_list, :position, :thumbnail_url

  has_many :tags, embed: :ids, embed_in_root: true, serializer: Barbecue::TagSerializer
  has_many :links, embed: :ids, embed_in_root: true, serializer: Admin::LinkSerializer

  attributes :media_placement_ids, :media_item_ids
#  has_many :media_placements, embed: :ids, embed_in_root: false #, serializer: Barbecue::MediaPlacementSerializer
#  has_many :media_items, embed: :ids, embed_in_root: false

  def media_placements_count
    object.media_placements_count || 0
  end

  def links_count
    object.links.count
  end

  def thumbnail_url
    object.cover_image.thumb('400x400#').url unless object.cover_image.nil?
  end


end
