class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :no_of_books_uploaded, :integer, default: 0
    add_column :users, :no_of_author_pref, :integer, default: 0
    add_column :users, :no_of_book_pref, :integer, default: 0
    add_column :users, :no_of_category_pref, :integer, default: 0  	
  end
end
