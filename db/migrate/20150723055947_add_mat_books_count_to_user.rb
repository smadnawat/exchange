class AddMatBooksCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :mat_books_count, :integer, default: 0
  end
end
