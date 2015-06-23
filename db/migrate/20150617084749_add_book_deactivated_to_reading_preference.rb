class AddBookDeactivatedToReadingPreference < ActiveRecord::Migration
  def change
    add_column :reading_preferences, :book_deactivated, :boolean, default: false
  end
end
