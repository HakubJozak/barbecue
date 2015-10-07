module Barbecue
  class LocalImage < MediaItem
    include Thumbnails

    translates :title, :copyright

    def reset_thumbnails
      if photo_uid_changed?
        self.thumbnail_sizes = {}
      end
    end
  end
end
