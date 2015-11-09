class AddAvatarToContactUs < ActiveRecord::Migration
  def change
    add_column :contact_us, :avatar, :string
  end
end
