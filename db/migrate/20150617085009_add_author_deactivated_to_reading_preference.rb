class AddAuthorDeactivatedToReadingPreference < ActiveRecord::Migration
  def change
    add_column :reading_preferences, :author_deactivated, :boolean, default: false
  end
end
