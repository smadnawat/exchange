class RemoveBookIdFromInvitations < ActiveRecord::Migration
  def change
    remove_reference :invitations, :book, index: true, foreign_key: true
  end
end
