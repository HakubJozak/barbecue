class Barbecue::MediaItem < ActiveRecord::Base
  self.table_name = 'media_items'

  translates :copyright
  #  belongs_to :owner, polymorphic: true

  # Relations
  # has_many :media_placements
  # has_many :owners, through: :media_placements

  # Validations
  validates :source_url, presence: true
end
