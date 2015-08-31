class AddByScanningToReadingPreference < ActiveRecord::Migration
  def change
    add_column :reading_preferences, :by_scanning, :boolean, default: false
  end
end
