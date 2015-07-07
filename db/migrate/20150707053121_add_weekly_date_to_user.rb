class AddWeeklyDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :weekly_date, :date
  end
end
