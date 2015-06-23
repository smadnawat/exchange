class AddLatitudeToUser < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :float, null: false, default: 0.0
  end
end
