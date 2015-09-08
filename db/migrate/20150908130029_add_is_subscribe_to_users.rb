class AddIsSubscribeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_subscribe, :boolean,default: true
  	add_column :users, :unsubscription_token, :string 	
  end
end
