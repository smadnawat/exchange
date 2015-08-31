class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :gender
      t.string :email
      t.string :password_digest
      t.string :author_prefernce
      t.string :genre_preference
      t.string :location
      t.string :gender
      t.date :date_signup
      t.string :picture

      t.timestamps null: false
    end
  end
end
