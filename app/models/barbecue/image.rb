module Barbecue
  class Image < MediaItem
    translates :title

    serialize :thumbnail_sizes, Hash

    before_validation do
      self.photo_url = source_url
    end

    dragonfly_accessor :photo

    def thumb(size)
      if sizes = thumbnail_sizes[size]
        ret = OpenStruct.new(sizes)
        ret.url = Dragonfly.app.remote_url_for(ret.uid)
        ret
      else
        sizes = thumbnail_sizes[size] = compute_sizes(size)
        update_column(:thumbnail_sizes,thumbnail_sizes)
        OpenStruct.new(sizes)
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
