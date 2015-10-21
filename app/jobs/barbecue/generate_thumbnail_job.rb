module Barbecue
  class GenerateThumbnailJob < ActiveJob::Base
    queue_as :slow

    def perform(image, size)
      sizes = image.thumbnail_sizes[size] = compute_sizes(image, size)
      image.update_attributes(thumbnail_sizes: image.thumbnail_sizes)
      # OpenStruct.new(sizes)
    end


    private

    def compute_sizes(image, size)
      unless image.thumbnail_sizes[size]
        thumbnail = image.photo.thumb(size, format: :jpg).encode('jpg', '-quality 85')
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
end
