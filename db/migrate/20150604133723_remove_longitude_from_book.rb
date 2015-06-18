class RemoveLongitudeFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :longitude, :string
  end
end
