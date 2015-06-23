class CreateReadingPreferences < ActiveRecord::Migration
  def change
    create_table :reading_preferences do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :genre, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
