module Barbecue
  class Image < MediaItem
    include Thumbnails

    translates :title, :copyright
    after_create :set_photo_url

    private
    def set_photo_url
      if !self.source_url.nil? && !self.source_url.empty?
        self.update_attribute(:photo_url, self.source_url)
      end
    end

  end
end
