class AddInvitationIdToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :invitation_id, :integer
  end
end
