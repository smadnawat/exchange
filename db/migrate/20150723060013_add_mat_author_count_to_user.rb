class AddMatAuthorCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :mat_author_count, :integer, default: 0
  end
end
