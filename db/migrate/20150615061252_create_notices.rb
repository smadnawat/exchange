class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.string :action_type
      t.integer :reciever_id
      t.boolean :pending

      t.timestamps null: false
    end
  end
end
