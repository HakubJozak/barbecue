module Barbecue
  class Image < MediaItem
    translates :title, :copyright

    serialize :thumbnail_sizes, Hash
    dragonfly_accessor :photo

    before_validation do
      if photo_uid_changed?
        self.thumbnail_sizes = {}
      end
    end

    # User w_x_h = 400x250# or similar
    #
    def thumb(w_x_h)
      if sizes = thumbnail_sizes[w_x_h]
        ret = OpenStruct.new(sizes)
        ret.url = Dragonfly.app.remote_url_for(ret.uid)
        ret
      else
        thumbnail_sizes[w_x_h] = compute_sizes(w_x_h)
        update_column(:thumbnail_sizes,thumbnail_sizes)
        OpenStruct.new(thumbnail_sizes[w_x_h])
      end
    end

    private

    def compute_sizes(size)
      thumbnail = self.photo.thumb(size, format: :jpg).encode('jpg', '-quality 80')
      {
        uid: thumbnail.store,
        signature: thumbnail.signature,
        url: thumbnail.url,
        width: thumbnail.width,
        height: thumbnail.height
      }
    end

  end
end
