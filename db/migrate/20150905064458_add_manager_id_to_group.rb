class AddManagerIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :manager_id, :integer
  end
end
