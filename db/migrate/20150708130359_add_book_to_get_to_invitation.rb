class AddBookToGetToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :book_to_get, :integer
  end
end
