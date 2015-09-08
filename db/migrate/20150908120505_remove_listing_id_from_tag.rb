class RemoveListingIdFromTag < ActiveRecord::Migration
  def change
    remove_column :tags, :listing_id, :integer
  end
end
