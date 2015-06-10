class AddUIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :u_id, :string, null: false, default: ""
  end
end
