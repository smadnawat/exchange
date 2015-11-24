class AddFieldsToContactUs < ActiveRecord::Migration
  def change
  	add_column :contact_us, :surname, :string
  	add_column :contact_us, :quotes, :string
  end
end
