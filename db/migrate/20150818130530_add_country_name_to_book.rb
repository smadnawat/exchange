class AddCountryNameToBook < ActiveRecord::Migration
  def change
    add_column :books, :country_name, :string
  end
end
