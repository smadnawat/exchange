class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :device_type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
