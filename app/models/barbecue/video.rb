class Barbecue::Video < Barbecue::MediaItem
  validates :source_url, presence: true
end
