class AddDeviceUsedToUser < ActiveRecord::Migration
  def change
    add_column :users, :device_used, :string
  end
end
