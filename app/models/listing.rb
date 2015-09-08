class Listing < ActiveRecord::Base
  belongs_to :outcode
  has_and_belongs_to_many :tags,
            :join_table => :listing_taggings
end
