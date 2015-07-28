class AddGetPreferenceToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :get_preference, :integer
    add_column :groups, :give_preference, :integer
  end
end
