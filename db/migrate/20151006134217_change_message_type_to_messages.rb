class ChangeMessageTypeToMessages < ActiveRecord::Migration
  def up
    change_column :messages, :message, :text
  end

  def down
    change_column :messages, :message, :string
  end
end
