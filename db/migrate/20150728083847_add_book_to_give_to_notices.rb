class AddBookToGiveToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :book_to_give, :integer
  end
end
