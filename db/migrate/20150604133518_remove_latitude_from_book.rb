class RemoveLatitudeFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :latitude, :string
  end
end
