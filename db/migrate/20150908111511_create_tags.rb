class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :name
      t.integer :listing_id

      t.timestamps null: false
    end
  end
end
