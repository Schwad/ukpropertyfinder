class AddSecretCodeToOutcode < ActiveRecord::Migration
  def change
    add_column :outcodes, :secret_code, :text
  end
end
