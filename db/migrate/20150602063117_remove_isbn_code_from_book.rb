class RemoveIsbnCodeFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :isbn_code, :string
  end
end
