class AddAddressToBook < ActiveRecord::Migration
  def change
    add_column :books, :address, :string, null: false, default: ""
  end
end
