class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :user_id
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
