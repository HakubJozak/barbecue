module Barbecue
  module Thumbnails
    extend ActiveSupport::Concern

    included do
      serialize :thumbnail_sizes, Hash
      dragonfly_accessor :photo
      before_validation :reset_thumbnails
    end

    # User w_x_h = 400x250# or similar
    #
    def thumb(w_x_h)
      if sizes = thumbnail_sizes[w_x_h]
        ret = OpenStruct.new(sizes)
        ret.url = Dragonfly.app.remote_url_for(ret.uid)
        ret
      else
        Barbecue::GenerateThumbnailJob.perform_later(self, size)
        sizes = size.split("x")
        OpenStruct.new(
          uid: nil,
          signature: nil,
          url: "http://dummyimage.com/#{size}/FFF/000.png&text=Generating…",
          width: sizes[0].to_i,
          height: sizes[1].to_i
        )
      end
    end

    def reset_thumbnails
      if photo_uid_changed?
        self.thumbnail_sizes = {}
      end
    end

    private

    def compute_sizes(size)
      thumbnail = self.photo.thumb(size, format: :jpg).encode('jpg', '-quality 85')
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
