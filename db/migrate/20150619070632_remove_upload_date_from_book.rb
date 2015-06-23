class RemoveUploadDateFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :upload_date, :date
  end
end
