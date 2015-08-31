class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :genre, null: false
      t.date :upload_date, null: false
      t.string :isbn_code
      t.string :upload_type, null: false
      t.string :latitude, null: false, default: 0.0
      t.string :longitude, null: false, default: 0.0
      t.references :user

      t.timestamps null: false
    end
  end
end
