class AddGenreDeactivatedToReadingPreference < ActiveRecord::Migration
  def change
    add_column :reading_preferences, :genre_deactivated, :boolean, default: false
  end
end
