class AddUploadDateForAdminToBook < ActiveRecord::Migration
  def change
    add_column :books, :upload_date_for_admin, :date
  end
end
