class CreateOutcodes < ActiveRecord::Migration
  def change
    create_table :outcodes do |t|
      t.text :code

      t.timestamps null: false
    end
  end
end
