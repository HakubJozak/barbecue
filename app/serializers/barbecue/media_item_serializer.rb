class Barbecue::MediaItemSerializer < Barbecue::BaseSerializer
  attributes :id, :title_en,:title_cs, :copyright_cs, :copyright_en, :type, :source_url, :thumbnail_url

  def type
    object.type.underscore
  end

  def thumbnail_url
    object.thumb('400x400#').url if object.respond_to?(:photo) && !object.photo.nil?
  end



end
