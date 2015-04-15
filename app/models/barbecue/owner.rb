# module Barbecue::Owner < ActiveRecord::Base
#   self.table_name = "places"

#   # Relations
#   acts_as_taggable
#   has_many :media_placements, dependent: :destroy
#   has_many :media_items, through: :media_placements, dependent: :destroy
# end
