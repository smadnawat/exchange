class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.integer :sender_id
      t.string :media
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
