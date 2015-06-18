class AddInvitationIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :invitation_id, :integer
  end
end
