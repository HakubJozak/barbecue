module Barbecue::Controller::Media

  private

  def media_item_attributes
    [ :id,
      :title_en,:title_cs,:source_url,
      :copyright_cs,:copyright_en,
      :type, :owner_id, :owner_type ]
  end

  alias :image_attributes :media_item_attributes

end
