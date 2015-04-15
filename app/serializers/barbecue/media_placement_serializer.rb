class Barbecue::MediaPlacementSerializer < Barbecue::BaseSerializer
  attributes :id, :position, :page, :featured, :cover_columns, :title_en, :title_cs #, :page_id,:page_type,
  has_one :media_item, embed: :ids, embed_in_root: true, serializer: Barbecue::MediaItemSerializer

  def page
    if object.page
      type = object.page.class.to_s
      { id: object.page_id, type: type }
    end
  end


end
