class AddImagePathToReadingPreference < ActiveRecord::Migration
  def change
    add_column :reading_preferences, :image_path, :string
  end
end
