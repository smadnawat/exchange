class AddGroupIdToNotice < ActiveRecord::Migration
  def change
    add_column :notices, :group_id, :integer
  end
end
