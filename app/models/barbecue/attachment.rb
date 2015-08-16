class Barbecue::Attachment < Barbecue::MediaItem
  dragonfly_accessor :photo
  validates :photo, presence: true

  alias :file :photo
end
