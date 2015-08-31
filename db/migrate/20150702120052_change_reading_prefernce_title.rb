class ChangeReadingPrefernceTitle < ActiveRecord::Migration
  def up
    change_column :reading_preferences, :title, :text
  end

  def down
    change_column :reading_preferences, :title, :string
  end
end
