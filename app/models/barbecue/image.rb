module Barbecue
  class Image < MediaItem
    include Thumbnails

    translates :title, :copyright
    validates :source_url, presence: true

    def reset_thumbnails
      if source_url_changed?
        self.thumbnail_sizes = {}
      end
    end
  end
end
