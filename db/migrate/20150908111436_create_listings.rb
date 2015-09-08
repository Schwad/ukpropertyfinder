class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :outcode, index: true, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.text :property_type
      t.integer :bedrooms
      t.integer :price
      t.text :identifier
      t.text :address
      t.text :summary
      t.text :small_thumb
      t.text :large_thumb

      t.timestamps null: false
    end
  end
end
