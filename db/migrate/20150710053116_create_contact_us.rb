class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :name
      t.string :email
      t.string :country
      t.string :gender
      t.string :author_code

      t.timestamps null: false
    end
  end
end
