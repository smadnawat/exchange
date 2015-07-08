class AddNotificationStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :notification_status, :boolean, default: true
  end
end
