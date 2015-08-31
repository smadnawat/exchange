class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :get_book_id
      t.integer :give_book_id

      t.timestamps null: false
    end
  end
end
