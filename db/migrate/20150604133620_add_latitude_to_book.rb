class AddLatitudeToBook < ActiveRecord::Migration
  def change
    add_column :books, :latitude, :float, null: false, default: 0.0
  end
end
