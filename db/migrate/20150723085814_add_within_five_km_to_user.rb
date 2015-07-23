class AddWithinFiveKmToUser < ActiveRecord::Migration
  def change
    add_column :users, :within_five_km, :integer, default: 0
    add_column :users, :date_within_five_km, :date
  end
end
