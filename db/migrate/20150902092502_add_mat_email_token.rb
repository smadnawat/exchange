class AddMatEmailToken < ActiveRecord::Migration
  def change
  	add_column :users, :mat_email_token, :string
  end
end
