class AddImagePathToBook < ActiveRecord::Migration
  def change
    add_column :books, :image_path, :string
  end
end
