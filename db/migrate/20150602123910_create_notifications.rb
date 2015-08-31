class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :subject
      t.text   :content
      t.string :location
      t.string :author
      t.string :genre
      t.string :all
      t.string :sub_locations, :array => true, :default => '{}'
      t.string :sub_authors, :array => true, :default => '{}'
      t.string :sub_genres, :array => true, :default => '{}'

      t.timestamps null: false
    end
  end
end
