class AddIsbn13ToReadingPreference < ActiveRecord::Migration
  def change
    add_column :reading_preferences, :isbn13, :string
  end
end
