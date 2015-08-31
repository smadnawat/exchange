class ChangeUploadDateOfBook < ActiveRecord::Migration
 def up
    change_column :books, :upload_date, :datetime
  end

  def down
    change_column :books, :upload_date, :integer
  end
end
