class AddBookToGiveToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :book_to_give, :integer
  end
end
