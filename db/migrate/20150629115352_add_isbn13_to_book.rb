class AddIsbn13ToBook < ActiveRecord::Migration
  def change
    add_column :books, :isbn13, :string
  end
end
