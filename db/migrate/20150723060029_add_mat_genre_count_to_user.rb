class AddMatGenreCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :mat_genre_count, :integer, default: 0
  end
end
