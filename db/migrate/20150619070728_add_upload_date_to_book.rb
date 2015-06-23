class AddUploadDateToBook < ActiveRecord::Migration
  def change
    add_column :books, :upload_date, :integer
  end
end
