class AddDeleteAuthorToReadingPreference < ActiveRecord::Migration
  def change
    add_column :reading_preferences, :delete_author, :boolean, default: false
    add_column :reading_preferences, :delete_genre, :boolean, default: false
  end
end
