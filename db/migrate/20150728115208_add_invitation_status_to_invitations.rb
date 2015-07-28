class AddInvitationStatusToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :invitation_status, :string
  end
end
