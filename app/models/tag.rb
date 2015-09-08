class Tag < ActiveRecord::Base
  has_and_belongs_to_many :listings,
            :join_table => :listing_taggings
end
