class AddAboutUsToBook < ActiveRecord::Migration
  def change
    add_column :books, :about_us, :text
  end
end
