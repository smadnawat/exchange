class AddLongitudeToUser < ActiveRecord::Migration
  def change
    add_column :users, :longitude, :float, null: false, default: 0.0
  end
end
