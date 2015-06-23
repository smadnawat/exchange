class AddLongitudeToBook < ActiveRecord::Migration
  def change
    add_column :books, :longitude, :float, null: false, default: 0.0
  end
end
